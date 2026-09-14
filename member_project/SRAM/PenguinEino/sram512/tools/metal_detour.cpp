// Single-net metal detour with hard physical obstacles, no congestion waiver.
#include <array>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <limits>
#include <queue>
#include <vector>
using namespace std;
struct Item {int f,g,u;bool operator<(const Item& o)const{return f>o.f || (f==o.f&&g<o.g);}};
int main(int argc,char**argv){
 if(argc!=3)return 2;
 ifstream in(argv[1],ios::binary);int h[5];in.read((char*)h,sizeof(h));
 int nx=h[0],ny=h[1],src=h[2],dst=h[3],vc=h[4],plane=nx*ny,n=3*plane;
 vector<uint8_t> free(n),via(2*plane);in.read((char*)free.data(),n);in.read((char*)via.data(),2*plane);
 if(!in||!free[src]||!free[dst])return 3;
 vector<int> dist(n,numeric_limits<int>::max()),parent(n,-1);
 auto heuristic=[&](int u){int p=u%plane,q=dst%plane;return abs(p%nx-q%nx)+abs(p/nx-q/nx);};
 priority_queue<Item> q;dist[src]=0;q.push({heuristic(src),0,src});int visited=0;
 int minx=nx,miny=ny,maxx=0,maxy=0;
 while(!q.empty()){
  auto a=q.top();q.pop();if(a.g!=dist[a.u])continue;visited++;
  if(a.u==dst)break;
  int u=a.u,p=u%plane,x=p%nx,y=p/nx;
  minx=min(minx,x);miny=min(miny,y);maxx=max(maxx,x);maxy=max(maxy,y);
  int layer=u/plane;
  array<int,6> next={x?u-1:-1,x+1<nx?u+1:-1,y?u-nx:-1,y+1<ny?u+nx:-1,
   layer==0?(via[p]?plane+p:-1):(via[(layer==2?plane:0)+p]?p:-1),
   layer==0&&via[plane+p]?2*plane+p:-1};
  for(int v:next){if(v<0||!free[v])continue;
   if(parent[u]>=0 && parent[u]%plane==p && v%plane==p && parent[u]/plane!=v/plane)continue;
   int g=a.g+(v/plane==layer?(layer==2?3:1):vc);
   if(g<dist[v]){dist[v]=g;parent[v]=u;q.push({g+heuristic(v),g,v});}
  }
 }
 cerr<<"visited "<<visited<<" points; ";
 if(dist[dst]==numeric_limits<int>::max()){cerr<<"no path; reached bbox "<<minx<<","<<miny<<" .. "<<maxx<<","<<maxy<<" of "<<nx<<","<<ny<<"\n";return 1;}
 cerr<<"path cost "<<dist[dst]<<"\n";
 vector<int> path;for(int u=dst;u>=0;u=parent[u])path.push_back(u);
 ofstream out(argv[2]);for(auto i=path.rbegin();i!=path.rend();++i)out<<*i<<'\n';
 return 0;
}
