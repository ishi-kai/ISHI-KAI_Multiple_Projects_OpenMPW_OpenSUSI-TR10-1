// Three-conductor grid maze router. Geometry legality is rasterized from
// real GDS; independent foundry DRC and schematic LVS remain mandatory.
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
struct Net {int id,allowgc; bool complete=false; vector<vector<int>> pins; vector<int> nodes,via_nodes; vector<pair<int,int>> edges;};
struct Item {float f,g;int u;bool operator<(Item const&b)const{return f>b.f;}};
template<class T> void readv(ifstream&f,vector<T>&v,int n){v.resize(n);f.read((char*)v.data(),n*sizeof(T));}
int main(int argc,char**argv){
 if(argc<3)return 2;ifstream f(argv[1],ios::binary);int h[4];f.read((char*)h,sizeof(h));
 int nx=h[0],ny=h[1],nn=h[2],iterations=h[3],plane=nx*ny,N=3*plane,sx=2*nx-1,sy=2*ny-1;
 int step=argc>3?atoi(argv[3]):5500;int halo=step==2750?1:0;
 bool selective=argc>4&&atoi(argv[4]);
 if(step!=5500&&step!=2750&&step!=550)return 3;
 vector<int> fixed,via,viafixed;readv(f,fixed,3*sx*sy);readv(f,via,2*plane);readv(f,viafixed,2*plane);
 vector<Net> nets(nn);for(auto&n:nets){int np;f.read((char*)&n.id,4);f.read((char*)&np,4);f.read((char*)&n.allowgc,4);n.pins.resize(np);for(auto&p:n.pins){int sz;f.read((char*)&sz,4);readv(f,p,sz);}}
 vector<int> used(N),usedvia(2*plane),owncut(plane,-1),parent(N),stamp(N),tree(N),hist(N);vector<float> dist(N);int clock=0;
 auto around=[&](int u,int radius,auto action){int l=u/plane,p=u%plane,x=p%nx,y=p/nx;
  for(int dy=-radius;dy<=radius;dy++)for(int dx=-radius;dx<=radius;dx++)
   if(x+dx>=0&&x+dx<nx&&y+dy>=0&&y+dy<ny)action(l*plane+(y+dy)*nx+x+dx);
 };
 auto nearby=[&](int u,auto action){int l=u/plane,p=u%plane,x=p%nx,y=p/nx;
  int radius=step==550?(l==0?5:l==1?9:3):(l==2?0:halo);
  for(int dy=-radius;dy<=radius;dy++)for(int dx=-radius;dx<=radius;dx++)
   if(x+dx>=0&&x+dx<nx&&y+dy>=0&&y+dy<ny)action(l*plane+(y+dy)*nx+x+dx);
 };
 auto own=[&](int x,int id){return x==0||x==id;};
 auto pointok=[&](int u,int id){int l=u/plane,p=u%plane;return own(fixed[l*sx*sy+2*(p/nx)*sx+2*(p%nx)],id);};
 auto edgeok=[&](int u,int v,int id){int l=u/plane,p=u%plane,q=v%plane;
  if(u/plane!=v/plane){int k=(u/plane==2||v/plane==2)?1:0;return !via[k*plane+p]&&own(viafixed[k*plane+p],id);}
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
  for(int ni:order){if(selective&&it&&!needs[ni]&&rng()%16)continue;auto&net=nets[ni];for(int u:net.nodes)used[u]--;for(int u:net.via_nodes)usedvia[u]--;net.nodes.clear();net.edges.clear();net.via_nodes.clear();fill(owncut.begin(),owncut.end(),-1);
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
     array<int,6>ne={x?u-1:-1,x+1<nx?u+1:-1,y?u-nx:-1,y+1<ny?u+nx:-1,l==0?plane+p:p,l==0?2*plane+p:-1};
     for(int v:ne){if(v<0||!pointok(v,net.id)||!edgeok(u,v,net.id))continue;
      if(v/plane==2&&(!net.allowgc||owncut[v%plane]==0))continue;
      if(step==550&&v/plane==2){bool bad=false;around(v,4,[&](int q){if(owncut[q%plane]==0)bad=true;});if(bad)continue;}
      bool change=(v/plane!=l),horizontal=(v==u+1||v==u-1);
      int connection=(v/plane==2||l==2)?1:0;
      if(change){
       if(owncut[p]>=0&&owncut[p]!=connection)continue;
       if(!connection&&tree[2*plane+p])continue;
       if(step==550&&!connection){bool bad=false;around(2*plane+p,4,[&](int q){if(tree[q])bad=true;});if(bad)continue;}
       if(parent[u]>=0&&parent[u]%plane==p&&parent[u]/plane!=l&&parent[u]/plane!=v/plane)continue;
       bool bad=false;if(step!=5500)around(p,step==550?5:1,[&](int q){if(owncut[q%plane]>=0&&owncut[q%plane]!=connection)bad=true;});
       // A V1 is 1.4 um wide with 1.5 um spacing. On a 2.75 um
       // candidate lattice, adjacent same-net cuts must also be excluded.
       if(!connection&&step!=5500)around(p,step==550?5:1,[&](int q){if(q%plane!=p&&owncut[q%plane]==0)bad=true;});
       if(bad)continue;
      }
      float base=change?(connection?6.0f:5.0f):(l==2?2.4f:((l==0)==horizontal?1.0f:1.6f));
      int occupancy=0;nearby(v,[&](int w){occupancy+=used[w];});
      if(v/plane==2)occupancy+=usedvia[v%plane];
      if(change&&!connection)occupancy+=used[2*plane+p]+usedvia[plane+p];
      if(change&&connection)occupancy+=usedvia[p];
      if(step==2750){
       if(v/plane==2)around(v,1,[&](int q){occupancy+=usedvia[plane+q%plane];});
       if(change&&connection)around(2*plane+p,1,[&](int q){occupancy+=used[q]+usedvia[q%plane];});
       if(change&&!connection)around(p,1,[&](int q){occupancy+=usedvia[plane+q%plane];});
      }
      if(step==550){
       if(v/plane==0){around(v,7,[&](int q){occupancy+=usedvia[q%plane];});around(v,6,[&](int q){occupancy+=usedvia[plane+q%plane];});}
       if(v/plane==2){around(v,4,[&](int q){occupancy+=usedvia[q%plane];});around(v,5,[&](int q){occupancy+=usedvia[plane+q%plane];});}
       if(change&&connection){around(2*plane+p,5,[&](int q){occupancy+=used[q]+usedvia[q%plane];});around(p,6,[&](int q){occupancy+=used[q]+usedvia[plane+q%plane];});}
       if(change&&!connection){around(p,7,[&](int q){occupancy+=used[q];});around(2*plane+p,4,[&](int q){occupancy+=used[q];});around(p,5,[&](int q){occupancy+=usedvia[plane+q%plane];});}
      }
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
    for(int v=goal;parent[v]>=0;v=parent[v]){net.edges.emplace_back(v,parent[v]);addtree(v);addtree(parent[v]);if(v/plane!=parent[v]/plane)owncut[v%plane]=(v/plane==2||parent[v]/plane==2)?1:0;}
    for(int u:pins)addtree(u);
   }
   net.complete=!failed;
   if(step!=5500){
    // Native pin polygons are already represented by the fixed geometry.
    // All their candidate access points belong to the search tree, but an
    // unused access point is not a newly drawn wire with a full-width halo.
    // Reserving halos around every such point falsely congests fine grids.
    unordered_set<int> routed;for(auto e:net.edges){routed.insert(e.first);routed.insert(e.second);}
    net.nodes.assign(routed.begin(),routed.end());
   }else net.nodes.assign(touched.begin(),touched.end());
   for(int u:net.nodes)used[u]++;
   unordered_set<int> cuts;for(auto e:net.edges)if(e.first/plane!=e.second/plane)cuts.insert(((e.first/plane==2||e.second/plane==2)?plane:0)+e.first%plane);
   net.via_nodes.assign(cuts.begin(),cuts.end());for(int u:net.via_nodes)usedvia[u]++;
  }
  // In a selective pass, a partially routed net can have valid edges but
  // still lack terminals. It must remain unresolved and be retried, even
  // when none of its current edges conflicts with another net.
  unrouted=count_if(nets.begin(),nets.end(),[](const Net&n){return !n.complete;});
  vector<int> conflicting(N),member(N),via_member(2*plane);int nc=0;
  for(auto&net:nets){nc++;for(int u:net.nodes)member[u]=nc;
   for(int u:net.via_nodes)via_member[u]=nc;
   for(int u:net.nodes)nearby(u,[&](int v){if(used[v]>(member[v]==nc?1:0))conflicting[u]=1;});
   for(int u:net.nodes)if(u/plane==2&&usedvia[u%plane])conflicting[u]=1;
   if(step==2750){
    for(int u:net.nodes)if(u/plane==2)around(u,1,[&](int q){int z=plane+q%plane;if(usedvia[z]>(via_member[z]==nc?1:0))conflicting[u]=1;});
    for(int u:net.via_nodes)if(u>=plane)around(u%plane,1,[&](int q){if(usedvia[q])conflicting[2*plane+u%plane]=1;});
   }
   if(step==550){
    for(int u:net.nodes){int l=u/plane;
     if(l==0||l==2){int radius=l==0?7:4;around(u,radius,[&](int q){int z=q%plane;if(usedvia[z]>(l==0&&via_member[z]==nc?1:0))conflicting[u]=1;});
      radius=l==0?6:5;around(u,radius,[&](int q){int z=plane+q%plane;if(usedvia[z]>(via_member[z]==nc?1:0))conflicting[u]=1;});}
    }
    for(int u:net.via_nodes)if(u>=plane)around(u%plane,5,[&](int q){if(usedvia[q])conflicting[2*plane+u%plane]=1;});
   }
   if(step==1100)for(int u:net.via_nodes)around(u,3,[&](int v){if(used[v]>(member[v]==nc?1:0))conflicting[u]=1;});
  }
  int conflicts=0;for(int u=0;u<N;u++)if(conflicting[u]){conflicts++;hist[u]++;}
  for(int i=0;i<nn;i++){needs[i]=!nets[i].complete||nets[i].edges.empty();for(int u:nets[i].nodes)if(conflicting[u]){needs[i]=1;break;}}
  cerr<<"iteration "<<it<<" conflicts "<<conflicts<<" unreachable "<<unrouted<<"\n";
  int score=conflicts+unrouted*N;
  if(score<bestscore){bestscore=score;bestedges.clear();for(auto&n:nets)bestedges.push_back(n.edges);
   // Preserve inspectable candidates during a long routing run. These are
   // explicitly marked incomplete and are never a DRC/LVS signoff.
   ofstream checkpoint(string(argv[2])+".best");checkpoint<<"0\n";
   for(auto&n:nets){checkpoint<<n.id<<" "<<n.edges.size()<<"\n";for(auto e:n.edges)checkpoint<<e.first<<" "<<e.second<<"\n";}
   ofstream diagnostic(string(argv[2])+".conflicts");
   for(int u=0;u<N;u++)if(conflicting[u]){
    diagnostic<<u/plane<<" "<<(u%plane)%nx<<" "<<(u%plane)/nx;
    for(auto&n:nets)if(find(n.nodes.begin(),n.nodes.end(),u)!=n.nodes.end())diagnostic<<" "<<n.id;
    diagnostic<<"\n";
   }
  }
  if(conflicts==0&&unrouted==0){success=true;break;}
 }
 if(!success)for(int i=0;i<nn;i++)nets[i].edges=bestedges[i];
 cerr<<"best congestion score "<<bestscore<<"\n";
 ofstream out(argv[2]);out<<success<<"\n";for(auto&n:nets){out<<n.id<<" "<<n.edges.size()<<"\n";for(auto e:n.edges)out<<e.first<<" "<<e.second<<"\n";}
 return success?0:1;
}
