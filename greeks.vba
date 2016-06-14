'It's later that I realized monte carlo can not generate a stable greek, 'cause the price itself changes from this to that, when
'running it once and agian.

Global Const Pi = 3.14159265358979

Option Explicit     'Requirs that all variables to be declared explicitly.
Option Compare Text 'Uppercase letters to be equivalent to lowercase letters.

Function delta_asian(callput As String, underlyingprice As Double, strikingprice As Double, time As Double, riskfree As Double, vol As Double, q As Double)
Dim d1, d2, a, sigmaav As Double

a = 0.5 * (riskfree - q - vol ^ 2 / 6)
sigmaav = vol / Sqr(3)
d1 = (Log(underlyingprice / strikingprice) + (a + 0.5 * sigmaav ^ 2) * time) / (sigmaav * Sqr(time))
d2 = d1 - sigmaav * Sqr(time)

If callput = "c" Then
delta_asian = Exp((a - riskfree) * time) * Application.NormSDist(d1)
ElseIf callput = "p" Then
delta_asian = Exp((a - riskfree) * time) * (Application.NormSDist(d1) - 1)
Else
MsgBox ("error")
End If

End Function


Function gamma_asian(underlyingprice As Double, strikingprice As Double, time As Double, riskfree As Double, vol As Double, q As Double)
Dim d1, d2, a, sigmaav As Double

a = 0.5 * (riskfree - q - vol ^ 2 / 6)
sigmaav = vol / Sqr(3)
d1 = (Log(underlyingprice / strikingprice) + (a + 0.5 * sigmaav ^ 2) * time) / (sigmaav * Sqr(time))
d2 = d1 - sigmaav * Sqr(time)

gamma_asian = Exp((a - riskfree) * time) * Exp(-d1 ^ 2 / 2) * (1 / Sqr(2 * Pi)) / (underlyingprice * sigmaav * Sqr(time))

End Function

Function vega_asian(underlyingprice As Double, strikingprice As Double, time As Double, riskfree As Double, vol As Double, q As Double)
Dim d1, d2, a, sigmaav As Double

a = 0.5 * (riskfree - q - vol ^ 2 / 6)
sigmaav = vol / Sqr(3)
d1 = (Log(underlyingprice / strikingprice) + (a + 0.5 * sigmaav ^ 2) * time) / (sigmaav * Sqr(time))
d2 = d1 - sigmaav * Sqr(time)

vega_asian = 0.01 * (underlyingprice * Exp((a - riskfree) * time) * Sqr(time / 3) * Exp(-d1 ^ 2 / 2) * (1 / Sqr(2 * Pi)) - sigmaav ^ 2 / 2 * time * underlyingprice * Exp((a - riskfree) * time) * Application.NormSDist(d1))

End Function

Function theta_asian(callput As String, underlyingprice As Double, strikingprice As Double, time As Double, riskfree As Double, vol As Double, q As Double)

Dim d1, d2, a, sigmaav As Double

a = 0.5 * (riskfree - q - vol ^ 2 / 6)
sigmaav = vol / Sqr(3)
d1 = (Log(underlyingprice / strikingprice) + (a + 0.5 * sigmaav ^ 2) * time) / (sigmaav * Sqr(time))
d2 = d1 - sigmaav * Sqr(time)

If callput = "c" Then
theta_asian = ((a - riskfree) * Exp((a - riskfree) * time) * Application.NormSDist(d1) - riskfree * strikingprice * Exp(-riskfree * time) * Application.NormSDist(d2) - 0.5 * sigmaav * strikingprice / Sqr(time) * Exp((a - riskfree) * time) * Exp(-d1 ^ 2 / 2) * (1 / Sqr(2 * Pi))) / 365
ElseIf callput = "p" Then
theta_asian = (-(a - riskfree) * Exp((a - riskfree) * time) * Application.NormSDist(-d1) + riskfree * strikingprice * Exp(-riskfree * time) * Application.NormSDist(-d2) - 0.5 * sigmaav * strikingprice / Sqr(time) * Exp((a - riskfree) * time) * Exp(-d1 ^ 2 / 2) * (1 / Sqr(2 * Pi))) / 365
Else
MsgBox ("error")
End If

End Function

Function rho_asian(callput As String, underlyingprice As Double, strikingprice As Double, time As Double, riskfree As Double, vol As Double, q As Double)
Dim d1, d2, a, sigmaav As Double

a = 0.5 * (riskfree - q - vol ^ 2 / 6)
sigmaav = vol / Sqr(3)
d1 = (Log(underlyingprice / strikingprice) + (a + 0.5 * sigmaav ^ 2) * time) / (sigmaav * Sqr(time))
d2 = d1 - sigmaav * Sqr(time)

If callput = "c" Then
rho_asian = 0.01 * (time * strikingprice * Exp(-riskfree * time) * Application.NormSDist(d2) - 0.5 * time * underlyingprice * Exp((a - riskfree) * time) * Application.NormSDist(d1))
ElseIf callput = "p" Then
rho_asian = -0.01 * (time * strikingprice * Exp(-riskfree * time) * Application.NormSDist(-d2) - 0.5 * time * underlyingprice * Exp((a - riskfree) * time) * Application.NormSDist(-d1))
Else
MsgBox ("error")
End If

End Function
