// Two-metal grid maze router. Geometry legality is rasterized from real GDS
// by routing.py; independent foundry DRC and schematic LVS remain mandatory.
#include <algorithm>
#include <array>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <limits>
#include <queue>
#include <random>
#include <unordered_set>
#include <vector>
using namespace std;
struct Net {int id; vector<vector<int>> pins; vector<int> nodes,via_nodes; vector<pair<int,int>> edges;};
struct Item {float f,g;int u;bool operator<(Item const&b)const{return f>b.f;}};
template<class T> void readv(ifstream&f,vector<T>&v,int n){v.resize(n);f.read((char*)v.data(),n*sizeof(T));}
int main(int argc,char**argv){
 if(argc<3)return 2;ifstream f(argv[1],ios::binary);int h[4];f.read((char*)h,sizeof(h));
 int nx=h[0],ny=h[1],nn=h[2],iterations=h[3],plane=nx*ny,N=2*plane,sx=2*nx-1,sy=2*ny-1;
 int step=argc>3?atoi(argv[3]):5500;int halo=step==2750?1:0;
 bool selective=argc>4&&atoi(argv[4]);
 if(step!=5500&&step!=2750&&step!=1100)return 3;
 vector<int> fixed,via,viafixed;readv(f,fixed,2*sx*sy);readv(f,via,plane);readv(f,viafixed,plane);
 vector<Net> nets(nn);for(auto&n:nets){int np;f.read((char*)&n.id,4);f.read((char*)&np,4);n.pins.resize(np);for(auto&p:n.pins){int sz;f.read((char*)&sz,4);readv(f,p,sz);}}
 vector<int> used(N),usedvia(plane),parent(N),stamp(N),tree(N),hist(N);vector<float> dist(N);int clock=0;
 auto around=[&](int u,int radius,auto action){int l=u/plane,p=u%plane,x=p%nx,y=p/nx;
  for(int dy=-radius;dy<=radius;dy++)for(int dx=-radius;dx<=radius;dx++)
   if(x+dx>=0&&x+dx<nx&&y+dy>=0&&y+dy<ny)action(l*plane+(y+dy)*nx+x+dx);
 };
 auto nearby=[&](int u,auto action){int l=u/plane,p=u%plane,x=p%nx,y=p/nx;
  int radius=step==1100?(l==0?2:4):halo;
  for(int dy=-radius;dy<=radius;dy++)for(int dx=-radius;dx<=radius;dx++)
   if(x+dx>=0&&x+dx<nx&&y+dy>=0&&y+dy<ny)action(l*plane+(y+dy)*nx+x+dx);
 };
 auto own=[&](int x,int id){return x==0||x==id;};
 auto pointok=[&](int u,int id){int l=u/plane,p=u%plane;return own(fixed[l*sx*sy+2*(p/nx)*sx+2*(p%nx)],id);};
 auto edgeok=[&](int u,int v,int id){int l=u/plane,p=u%plane,q=v%plane;
  if(u/plane!=v/plane)return !via[p]&&own(viafixed[p],id);
  int x=(p%nx)+(q%nx),y=p/nx+q/nx;return own(fixed[l*sx*sy+y*sx+x],id);
 };
 vector<int> order(nn);for(int i=0;i<nn;i++)order[i]=i;
 stable_sort(order.begin(),order.end(),[&](int a,int b){return nets[a].pins.size()>nets[b].pins.size();});
 mt19937 rng(512);bool success=false;
 vector<int> needs(nn,1);
 int bestscore=numeric_limits<int>::max();vector<vector<pair<int,int>>> bestedges;
 for(int it=0;it<iterations;it++){
  int unrouted=0;float pressure=2.0f;
  if(it)shuffle(order.begin(),order.end(),rng);
  for(int ni:order){if(selective&&it&&!needs[ni]&&rng()%16)continue;auto&net=nets[ni];for(int u:net.nodes)used[u]--;for(int u:net.via_nodes)usedvia[u]--;net.nodes.clear();net.edges.clear();net.via_nodes.clear();
   fill(tree.begin(),tree.end(),0);unordered_set<int> touched;bool failed=false;
   int minx=nx,maxx=0,miny=ny,maxy=0;
   auto addtree=[&](int u){tree[u]=1;touched.insert(u);int p=u%plane;minx=min(minx,p%nx);maxx=max(maxx,p%nx);miny=min(miny,p/nx);maxy=max(maxy,p/nx);};
   auto heuristic=[&](int u){int p=u%plane,x=p%nx,y=p/nx;return float(max({minx-x,0,x-maxx})+max({miny-y,0,y-maxy}));};
   for(int u:net.pins[0])addtree(u);
   vector<int> todo;for(int j=1;j<(int)net.pins.size();j++)todo.push_back(j);
   while(!todo.empty()){
    auto near=min_element(todo.begin(),todo.end(),[&](int a,int b){float da=1e9,db=1e9;for(int u:net.pins[a])da=min(da,heuristic(u));for(int u:net.pins[b])db=min(db,heuristic(u));return da<db;});
    int pi=*near;todo.erase(near);auto&pins=net.pins[pi];bool connected=false;for(int u:pins)if(tree[u])connected=true;
    if(connected){for(int u:pins)addtree(u);continue;}
    clock++;priority_queue<Item>pq;for(int u:pins){if(!pointok(u,net.id))continue;stamp[u]=clock;dist[u]=0;parent[u]=-1;pq.push({heuristic(u),0,u});}
    int goal=-1;while(!pq.empty()){
     auto a=pq.top();pq.pop();int u=a.u;if(a.g!=dist[u])continue;if(tree[u]){goal=u;break;}
     int l=u/plane,p=u%plane,x=p%nx,y=p/nx;
     array<int,5>ne={x?u-1:-1,x+1<nx?u+1:-1,y?u-nx:-1,y+1<ny?u+nx:-1,(1-l)*plane+p};
     for(int v:ne){if(v<0||!pointok(v,net.id)||!edgeok(u,v,net.id))continue;
      bool change=(v/plane!=l),horizontal=(v==u+1||v==u-1);
      float base=change?5.0f:((l==0)==horizontal?1.0f:1.6f);
      int occupancy=0;nearby(v,[&](int w){occupancy+=used[w];});
      if(step==1100){
       // An M1 wire is 1.8 um, while a V1 landing is 3.4 um. Include
       // the larger landing clearance independently of track clearance.
       if(v/plane==0)around(v,3,[&](int w){occupancy+=usedvia[w%plane];});
       if(change)around(v%plane,3,[&](int w){occupancy+=used[w];});
      }
      float cost=base+pressure*occupancy*20.0f+hist[v]*10.0f;
      float g=a.g+cost;if(stamp[v]!=clock||g<dist[v]){stamp[v]=clock;dist[v]=g;parent[v]=u;pq.push({g+heuristic(v),g,v});}
     }
    }
    if(goal<0){failed=true;cerr<<"unreachable net "<<net.id<<" terminal "<<pi<<"\n";break;}
    for(int v=goal;parent[v]>=0;v=parent[v]){net.edges.emplace_back(v,parent[v]);addtree(v);addtree(parent[v]);}
    for(int u:pins)addtree(u);
   }
   if(failed)unrouted++;
   if(step!=5500){
    // Native pin polygons are already represented by the fixed geometry.
    // All their candidate access points belong to the search tree, but an
    // unused access point is not a newly drawn wire with a full-width halo.
    // Reserving halos around every such point falsely congests fine grids.
    unordered_set<int> routed;for(auto e:net.edges){routed.insert(e.first);routed.insert(e.second);}
    net.nodes.assign(routed.begin(),routed.end());
   }else net.nodes.assign(touched.begin(),touched.end());
   for(int u:net.nodes)used[u]++;
   unordered_set<int> cuts;for(auto e:net.edges)if(e.first/plane!=e.second/plane)cuts.insert(e.first%plane);
   net.via_nodes.assign(cuts.begin(),cuts.end());for(int u:net.via_nodes)usedvia[u]++;
  }
  vector<int> conflicting(N),member(N);int nc=0;
  for(auto&net:nets){nc++;for(int u:net.nodes)member[u]=nc;
   for(int u:net.nodes)nearby(u,[&](int v){if(used[v]>(member[v]==nc?1:0))conflicting[u]=1;});
   if(step==1100)for(int u:net.via_nodes)around(u,3,[&](int v){if(used[v]>(member[v]==nc?1:0))conflicting[u]=1;});
  }
  int conflicts=0;for(int u=0;u<N;u++)if(conflicting[u]){conflicts++;hist[u]++;}
  for(int i=0;i<nn;i++){needs[i]=nets[i].edges.empty();for(int u:nets[i].nodes)if(conflicting[u]){needs[i]=1;break;}}
  cerr<<"iteration "<<it<<" conflicts "<<conflicts<<" unreachable "<<unrouted<<"\n";
  int score=conflicts+unrouted*N;
  if(score<bestscore){bestscore=score;bestedges.clear();for(auto&n:nets)bestedges.push_back(n.edges);}
  if(conflicts==0&&unrouted==0){success=true;break;}
 }
 if(!success)for(int i=0;i<nn;i++)nets[i].edges=bestedges[i];
 cerr<<"best congestion score "<<bestscore<<"\n";
 ofstream out(argv[2]);out<<success<<"\n";for(auto&n:nets){out<<n.id<<" "<<n.edges.size()<<"\n";for(auto e:n.edges)out<<e.first<<" "<<e.second<<"\n";}
 return success?0:1;
}
