//This is C++ code head file
#include <numeric>  // Necessary for std::accumulate
#include <vector>
#include <iostream>
#include <cmath>
#include <algorithm>    // Needed for the "max" function

double gaussian_box_muller() //function to get rand number
{
  double x = 0.0;
  double y = 0.0;
  double euclid_sq = 0.0;

  // Continue generating two uniform random variables
  // until the square of their "euclidean distance" 
  // is less than unity
  do {
   x = 2.0 * rand() / static_cast<double>(RAND_MAX)-1;
   y = 2.0 * rand() / static_cast<double>(RAND_MAX)-1;
   euclid_sq = x*x + y*y;
  } while (euclid_sq >= 1.0);

  return x*sqrt(-2*log(euclid_sq)/euclid_sq);
}

void calc_path_spot_prices(std::vector<double>& spot_prices,  // Vector of spot prices to be filled in
  const double& r,   // Risk free interest rate (constant)
  const double& v,   // Volatility of underlying (constant)
  const double& T) { // Expiry
  // Since the drift and volatility of the asset are constant
  // we will precalculate as much as possible for maximum efficiency
  double dt = T/static_cast<double>(spot_prices.size());
  double drift = exp(dt*(r-0.5*v*v));
  double vol = sqrt(v*v*dt);

 for (int i=1; i<spot_prices.size(); i++) 
  {
 double gauss_bm = gaussian_box_muller();
 spot_prices[i] = spot_prices[i-1] * drift * exp(vol*gauss_bm);
  }
}

int max(double a , double b) // in case of no max function, I write one
{
	if (a<=b)
	{
		return b;
	}
	else
	{
		return a;
	}
}
