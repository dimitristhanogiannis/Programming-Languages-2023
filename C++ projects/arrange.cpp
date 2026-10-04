#include <iostream>
#include <fstream>
#include <stack>
#include <vector>

using namespace std;

struct node {
    node(int d, node *l, node *r) : data(d), left(l), right(r) {}
    ~node() { delete left; delete right;}

    int data;
    node *left, *right;
};

node *toTree(vector<int> a, int N){

  stack<node *> s;
  node *t;
  node *root = new node(a[0], nullptr, nullptr);
  t = root;
  t->right = new node(0,nullptr,nullptr);
  t->left = new node(0,nullptr,nullptr);
  s.push(t->right);
  s.push(t->left);
  for(int i = 1; i<N; i++){
    if (a[i] != 0){
        t = s.top();
        s.pop();
        t->data = a[i];
        t->right = new node(0,nullptr,nullptr);
        t->left = new node(0,nullptr,nullptr);
        s.push(t->right);
        s.push(t->left);
    }
    else if (a[i]==0){
          s.pop();
    }
  }
  return root;
}

void swap(node* t){
        node* temp = t->left;
        t->left = t->right;
        t->right = temp;
}

vector<int> arrange(node *t){
   if (t->data == 0){
           vector<int> v = {};
           return v;
   }
   vector<int> v1 = arrange(t->left);
   vector<int> v2 = arrange(t->right);

   if (!v1.empty() && !v2.empty()){
      if (v2[0] < v1[0]) {
            swap(t);
            v2.push_back(t->data);
            v2.insert(v2.end(),v1.begin(),v1.end());
            return v2;
      }
      else{
            v1.push_back(t->data);
            v1.insert(v1.end(),v2.begin(),v2.end());
            return v1;
     }
   }
   else if (!v1.empty() && v2.empty()){
      if(v1[0] > t->data) {
            swap(t);
            v2.push_back(t->data);
            v2.insert(v2.end(),v1.begin(),v1.end());
            return v2;
      }
      else{
            v1.push_back(t->data);
            v1.insert(v1.end(),v2.begin(),v2.end());
            return v1;
     }
   }
   else if (!v2.empty() && v1.empty()){
      if(v2[0] < t->data) {
            swap(t);
            v2.push_back(t->data);
            v2.insert(v2.end(),v1.begin(),v1.end());
            return v2;
      }
      else{
            v1.push_back(t->data);
            v1.insert(v1.end(),v2.begin(),v2.end());
            return v1;
     }
   }
   else{
            v1.push_back(t->data);
            v1.insert(v1.end(),v2.begin(),v2.end());
            return v1;
     }

}

void print_tree(node *t) {
    if (t == nullptr)
        return;

    if (t->data != 0) {
        print_tree(t->left);
        cout << t->data << " ";
        print_tree(t->right);
    }
}

int main(int argc, char *argv[]){

  node* t;
  int N;

  ifstream myfile;

  myfile.open(argv[1]);

  myfile >> N;

  vector<int> a;

  int k;
  while (myfile >> k) {
      a.push_back(k);
  }

  myfile.close();

  t = toTree(a, a.size());
  vector<int> v = arrange(t);
  for(long unsigned int i=0; i < v.size(); i++)
  cout << v.at(i) << ' ';
  cout << endl;
  delete t;
  return 0;
}