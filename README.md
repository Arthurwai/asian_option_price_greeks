# asian_option_price_greeks
pricing Asian option, using Monte Carlo method, and greeks assembled by Geometric Asian option

I first read Turnbll& Wakeman(1991), and use the idea they suggested to pricing arithmetic average asian option. And, with the hand 
of my collegues, I successfully get it down. But, I'm a constrctor of an OTC option team, I have to know how to caculate the greeks
of such an option, in order to hedge. So that I use Monte Carlo method to pricing asian option, and try to use the difference in 
price, whom altered by underlying price, to caculate delta, but to find it unstable(doesn't matter big or small, the single of delta
 change from time to time, which is not good. 

So that, I turn to Geometric average asian option for help．In fact, I still don't know if geometric average and arithmetic average
can be nearly the same. I have to check it. For now, I usecontinuous geometric average instead of arithmetic average to get the near
greeks of asian option.
 
