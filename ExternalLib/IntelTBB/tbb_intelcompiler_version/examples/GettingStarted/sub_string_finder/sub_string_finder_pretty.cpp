/*
    Copyright 2005-2010 Intel Corporation.  All Rights Reserved.

    The source code contained or described herein and all documents related
    to the source code ("Material") are owned by Intel Corporation or its
    suppliers or licensors.  Title to the Material remains with Intel
    Corporation or its suppliers and licensors.  The Material is protected
    by worldwide copyright laws and treaty provisions.  No part of the
    Material may be used, copied, reproduced, modified, published, uploaded,
    posted, transmitted, distributed, or disclosed in any way without
    Intel's prior express written permission.

    No license under any patent, copyright, trade secret or other
    intellectual property right is granted to or conferred upon you by
    disclosure or delivery of the Materials, either expressly, by
    implication, inducement, estoppel or otherwise.  Any license under such
    intellectual property rights must be express and approved by Intel in
    writing.
*/

#include <iostream>
#include <string>
#include <algorithm>

#include "tbb/parallel_for.h"
#include "tbb/blocked_range.h"

using namespace tbb;
static const size_t N = 9;

class SubStringFinder {
 const std::string str;
 size_t *max_array;
 size_t *pos_array;
 public:
 void operator() ( const blocked_range<size_t>& r ) const {
  for ( size_t i = r.begin(); i != r.end(); ++i ) {
   size_t max_size = 0, max_pos = 0;
   for (size_t j = 0; j < str.size(); ++j) 
    if (j != i) {
     size_t limit = str.size()-( i > j ? i : j );
     for (size_t k = 0; k < limit; ++k) {
      if (str[i + k] != str[j + k]) break;
      if (k+1 > max_size) {
       max_size = k+1;
       max_pos = j;
      }
     }
    }
   max_array[i] = max_size;
   pos_array[i] = max_pos;
  }
 }
 SubStringFinder(std::string &s, size_t *m, size_t *p) :
  str(s), max_array(m), pos_array(p) { }
};

int main(int argc, char *argv[]) {
 

 std::string str[N] = { std::string("a"), std::string("b") };
 for (size_t i = 2; i < N; ++i) str[i] = str[i-1]+str[i-2];
 std::string &to_scan = str[N-1]; 
 std::cout << "String to scan: " << to_scan << std::endl;

 size_t *max = new size_t[to_scan.size()];
 size_t *pos = new size_t[to_scan.size()];

 parallel_for(blocked_range<size_t>(0, to_scan.size(), 100),
       SubStringFinder( to_scan, max, pos ) );

 for (size_t i = 0; i < to_scan.size(); ++i) {
   for (size_t j = 0; j < to_scan.size(); ++j) {
     if (j >= i && j < i + max[i]) std::cout << "_";
     else std::cout << " ";
   } 
   std::cout << std::endl << to_scan << std::endl;

   for (size_t j = 0; j < to_scan.size(); ++j) {
     if (j >= pos[i] && j < pos[i] + max[i]) std::cout << "*";
     else std::cout << " ";
   }
   std::cout << std::endl;
 }
 delete[] max;
 delete[] pos;
 return 0;
}
