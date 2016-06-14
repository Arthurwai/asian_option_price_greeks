void main()//(double S, double K, double r, double v, double T) {

// First we create the parameter list
  // Note that you could easily modify this code to input the parameters
  // either from the command line or via a file
  unsigned num_sims = 100000;   // Number of simulated asset paths
  unsigned num_intervals; 
  num_intervals=30;//ceil(T*365);
  Number of intervals for the asset path to be sampled 
  double S = 6833.0;  // Option price
  double K = 6951.83;  // Strike price
  double r = 0.07;   // Risk-free rate (7%)
  double v = 0.25;    // Volatility of the underlying (25%)
  double T = 0.0822;    // One year until expiry

  std::vector<double> spot_prices(num_intervals,S);  // The vector of spot prices

  double payoff_sum = 0.0;
  for (int i=0; i<num_sims; i++) {
    calc_path_spot_prices(spot_prices, r, v, T);
	unsigned num_times = spot_prices.size();
    double sum = std::accumulate(spot_prices.begin(), spot_prices.end(), 0); 
    double arith_mean = sum / static_cast<double>(num_times);  //arithmetic average price
    payoff_sum += max(arith_mean-K,0); //pay_off for call option
  }
  double discount_payoff_avg = (payoff_sum / static_cast<double>(num_sims)) * exp(-r*T);
  std::cout<< discount_payoff_avg<<std::endl;
}
