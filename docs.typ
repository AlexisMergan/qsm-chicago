#import "typst/template_paper.typ": *
#import "typst/common_commands.typ": *

#set figure.caption(position: top)
#set math.equation(numbering: "(1)")

#show raw.where(block: true): block.with(
  fill: luma(250),
  stroke: luma(100) + 1pt,
  inset: 6pt,
  radius: 4pt,
)

#show quote: set align(center)

#set enum(indent: 5pt)
#set list(indent: 5pt)
#set par(
  leading: 1em,
  first-line-indent: 1em,
  justify: true,
)
#show ref: set text(blue)
#show ref: underline
#show link: set text(blue)
#show link: underline

#let title = [Quantitative Spatial Models in Economics: A Simple Commuting Model of Chicago]
#let author = "Connacher Murphy"

#show: paper.with(
  title: title,
  authors: (
    author,
  ),
  date: datetime.today().display("[month repr:long] [day], [year]"),
)

#pad(
  left: 10%,
  right: 10%
)[
  #set par(
    leading: 1em,
    first-line-indent: 0em,
    justify: true,
  )
  #quote(
    block: true,
    attribution: [Carl Sandburg]
  )[
    Hog Butcher for the World, \
    Tool Maker, Stacker of Wheat, \
    Player with Railroads and the Nation's Freight Handler; \
    Stormy, husky, brawling, \
    City of the Big Shoulders...

    Come and show me another city with lifted head singing so proud to be alive and coarse and strong and cunning.
  ]

  #align(center)[*Abstract*]

  This repository demonstrates the basics of conducting economics research with quantitative spatial models (QSMs). I derive and calibrate a simple quantitative spatial model of Chicago and conduct two counterfactual exercises. I then repeat this process for a richer model and compare the results. This exercise is intended for pedagogical purposes. To this end, the models below are simplified versions of QSMs commonly used in economics research. I welcome any comments and questions.
]

= Introduction
The models presented below might strike you as restrictive and unrealistic. I have opted for an especially simple pair of models to demonstrate the basic mechanics of quantitative spatial models. This document will hopefully make the richer models of the literature more accessible. All quantitative spatial models (indeed, all models) necessarily abstract from certain features of reality. Results must always be interpreted in light of a researcher's modeling choices and the appropriateness of these choices for the research question at hand.

#cite(<ahlfeldt_ea_2015>, form: "prose") and #cite(<monte_ea_2018>, form: "prose") are popular examples of such models and provide a good introduction to the literature. #cite(<redding_rossi-hansberg_2017>, form: "prose") review the literature and outline the common components of economic geography models. Models of economic geography often draw from the seminal work of #cite(<eaton_kortum_2002>, form: "prose") in international trade.

= Model
I begin with a simple model of commuting to demonstrate the basic mechanics of a common form of QSM. I then extend this model to include (some) other relevant features of a spatial economy.

== A Simple Model (Model A)
Chicago is comprised of discrete neighborhoods $i, n, k, l in cal(L)$. Each location $i$ has a fixed mass $R_i$ of residents.

=== Workers
Each agent inelastically supplies one unit of labor. An agent $omega$ residing in location $i$ and working in location $n$ receives indirect#footnote[I omit the subproblem of utility maximization given location choice for parsimony. Model B will explicitly discuss this subproblem, which nests the subproblem of utility maximization in this model. We can set $alpha = 1$ to see the equivalence.] utility $cal(U)_(i n omega)$, where
  $
    cal(U)_(i n omega) &= (w_n / kappa_(i n)) b_(i n omega).
  $
$w_n$ is the wage paid in location $n$. $kappa_(i n)$ is a commuting cost of the iceberg form in utility units. $b_(i n omega)$ is an idiosyncratic preference shock with a Fréchet distribution. The cumulative distribution function of $b_(i n omega)$ is given by $F_(i n)(b_(i n omega)) = exp(-b_(i n omega)^(-theta))$. $theta$ governs the dispersion of this preference shock.

A worker $omega$ in location $i$ chooses the workplace that maximizes their indirect utility:
  $
    n_(i omega)^(*) eq.def arg max_(n in cal(L)) cal(U)_(i n omega).
  $
Since workers in location $i$ differ only in their draws of ${b_(i n omega)}_(n in cal(L))$ of preference shocks, we can drop the $omega$ subscript in what follows. The Fréchet-distributed preference shock implies
  $
    pi_(i n | i) &eq.def PP{n_(i)^(*) = n}
    &= phi_(i n) Phi_i^(-1), \
    "where"quad phi_(i n)
    &eq.def (w_n / kappa_(i n))^(theta) \
    "and" Phi_i
    &eq.def sum_(k in cal(L)) phi_(i k).
  $<eqn:mA-commute-probability>

#cite(<train_2003>, form: "prose"), especially the first three chapters, is an excellent resource on discrete choice models. If you are unfamiliar with the result in @eqn:mA-commute-probability, I recommend starting there. You can access the book #link("https://eml.berkeley.edu/books/choice2.html")[here].#footnote[I welcome your feedback. Would it be useful to include the derivation of @eqn:mA-commute-probability here?]

// CM: add a discrete choice citation

// CM: change all equation references to mX- standard

=== Firms
A unit mass of perfectly competitive firms in each neighborhood produce a freely traded final good priced at $1$ with the technology
  $
    Y_n = tilde(A)_n L_n^beta K_n^(1 - beta),
  $
where $tilde(A)_n$ is a productivity parameter, $L_n$ is labor input, and $K_n$ is capital input. We assume that each neighborhood has a fixed stock of immobile capital $overline(K)_n$, so it suffices to consider the production function
  $
    Y_n = A_n L_n^beta,
  $
where $A_n = tilde(A)_n overline(K)_n^(1 - beta)$. These perfectly competitive firms will pay workers their marginal product; wage and labor demand in neighborhood $n$ are thus given by
  $
    w_n &= beta A_n L_n^(beta - 1) \
    arrow.r.double.long
    L_n &= ((beta A_n) / w_n)^(1 / (1 - beta)).
  $<eqn:mA-wages>
We assume that capital owners spend all their rental income in the city so that goods market clearing still holds. This model shuts down an important margin of adjustment: changing capital stocks. We could also consider firms that compete in the same land markets as residents (we introduce a residential land market in model B). Again, results must always be interpreted in light of such modeling choices and their appropriateness for the research question.

=== Commuting Equilibrium
For the commuting market to clear, labor demand in location $n$ must equal labor supply to location $n$ across all residential locations $i$:
  $
    L_n = sum_(i in cal(L)) pi_(i n | i) R_i.
  $<eqn:mA-commuting-clearing>
We can substitute @eqn:mA-commute-probability and @eqn:mA-wages into this expression to obtain an equilibrium characterization:
  $
    underbrace(((beta A_n) / w_n)^(1 / (1 - beta)), "Labor Demand")
    = underbrace(sum_(i in cal(L)) phi_(i n) Phi_i^(-1) R_i, "Labor Supply").
  $<eqn:mA-commuting-equilibrium>

We can now define the competitive equilibrium. Given the model parameters ${beta, theta}$, the vector of residential populations $bold(R)$, and the exogenous location characteristics ${overline(bold(K)), bold(A), bold(kappa)}$, the equilibrium is a vector of quantities $bold(L)$ and a vector of prices $bold(w)$ that satisfy @eqn:mA-commute-probability, @eqn:mA-commuting-clearing, and @eqn:mA-commuting-equilibrium.

#cite(<alvarez_lucas_2007>, form: "prose") establish conditions for the existence and uniqueness of the equilibrium in #cite(<eaton_kortum_2002>, form: "prose"). They use an excess demand representation similar to @eqn:mA-commuting-equilibrium.

=== Welfare
We can compute expected utility by considering indirect utility. Expected utility for an agent residing in location $i$ will be given by the expected utility in their most attractive workplace:
$
  U_i eq.def EE[cal(U)_(i n^*_(i omega) omega)]
  = sum_n pi_(i n | i) EE[cal(U)_(i n omega) | n^*_(i omega) = n],
$
where we have used the law of iterated expectations. In order to compute this expectation, we need the distribution of $cal(U)_(i n omega)$ conditional on $n^*_(i omega) = n$. We derive this distribution below:
$
  PP {cal(U)_(i n omega) < u | n^*_(i omega) = n}
  &= (PP {cal(U)_(i n omega) < u and n^*_(i omega) = n})
  / (PP {n^*_(i omega) = n}) \
  &= 1 / pi_(i n | i) PP {b_(i n omega) < u (kappa_(i n) / w_n) and n^*_(i omega) = n} \
  &= 1 / pi_(i n | i) integral_0^(u (kappa_(i n) / w_n)) product_(k != n) F_(i k)(w_(i n) / kappa_(i n) kappa_(i k) / w_(i k)  b) d F_(i n)(b) \
  &= 1 / pi_(i n | i) integral_0^(u (kappa_(i n) / w_n)) product_(k) F_(i k)(w_(i n) / kappa_(i n) kappa_(i k) / w_(i k)  b) theta b^(-theta - 1) d b \
  &= 1 / pi_(i n | i) integral_0^(u (kappa_(i n) / w_n)) exp (-sum_(k) (w_(i n) / kappa_(i n) kappa_(i k) / w_(i k)  b)^(-theta)) theta b^(-theta - 1) d b \
  &= 1 / pi_(i n | i) integral_0^(u (kappa_(i n) / w_n)) exp (-pi_(i n | i)^(-1) b^(-theta)) theta b^(-theta - 1) d b \
  &= 1 / pi_(i n | i) integral_0^(u (kappa_(i n) / w_n)) exp (-pi_(i n | i)^(-1) b^(-theta)) theta b^(-theta - 1) d b \
  &= 1 / pi_(i n | i) [pi_(i n | i) exp(-pi_(i n | i)^(-1) b^(-theta)) |_0^(u(kappa_(i n) / w_n))]  \
  &= exp(-Phi_i u^(-theta)),
$
which is a Fréchet distribution with shape $theta$ and scale parameter $Phi_i^(1 / theta)$; herein lies Fréchet magic! We can then use the expression for the mean of a Fréchet distribution to compute the expected utility of an agent residing in location $i$:
$
  U_i
  &= sum_n pi_(i n | i) EE[cal(U)_(i n omega) | n^*_(i omega) = n] \
  &= sum_n pi_(i n | i) [Gamma(1 - 1 / theta) Phi_i^(1 / theta)] \
  &= Gamma(1 - 1 / theta) Phi_i^(1 / theta).
$<eqn:mA-utility>
These derivations are used widely across the literature and usually relegated to an appendix or omitted entirely. Researchers will appeal to the standard results from discrete choice, as the steps are usually similar or identical across models. I would encourage you to derive these results yourself once or twice before appealing to the standard results.#footnote[Are any of the steps above unclear? Please let me know and I can clarify the exposition.]

=== Counterfactual Equilibria
// I will denote the vector-collection of a variable $x_i$ over all locations with boldface: ${x_i}_(i in cal(L)) eq.def bold(x)$.
We consider a baseline equilibrium ${bold(w)^0, bold(pi)^0}$ for parameters ${bold(A)^0, bold(kappa)^0, bold(R)^0}$ and a counterfactual equilibrium ${bold(w)^prime, bold(pi)^prime}$ for parameters ${bold(A)^prime, bold(kappa)^prime, bold(R)^prime}$. We denote proportional changes with hats, e.g.,
  $
    hat(w)_n = (w_n^prime) / w_n^0 arrow.r.double.long w_n^0 hat(w)_n = w_n^prime.
  $
This representation leads us to 'exact hat algebra,' a popular method to model and summarize counterfactual equilibria. We start by expressing the market clearing condition for the counterfactual equilibrium and then substitute in @eqn:mA-wages:
$
  L_n^0 hat(L)_n &= (sum_(i in cal(L)) (pi_(i n | i)^0 R_i^0) (hat(pi)_(i n | i) hat(R)_i)) \
  arrow.r.double.long ((hat(A)_n) / hat(w)_n)^(1 / (1 - beta)) &= (sum_(i in cal(L)) (pi_(i n | i)^0 R_i^0) (hat(pi)_(i n | i) hat(R)_i)) / L_n^0.
$<eqn:mA-exact-hat-clearing>
We can use @eqn:mA-commute-probability to write
  $
    hat(pi)_(i n | i)
    &= hat(phi)_(i n) hat(Phi)_i^(-1), \
    "where"quad hat(phi)_(i n)
    &eq.def (hat(w)_n / hat(kappa)_(i n))^(theta) \
    "and" hat(Phi)_i
    &eq.def sum_(k in cal(L)) pi_(i k | i)^(0) hat(phi)_(i k)
  $<eqn:mA-exact-hat-pi>
The substantive piece of this expression is $hat(Phi)_i$. We derive it below:
  $
    hat(Phi)_i
    =
    (
      sum_(k in cal(L))
      text(
        fill: #red,
        phi_(i k)^0
      )
      hat(phi)_(i k)
    ) /
    (
      text(
        fill: #red,
        sum_(l in cal(L)) phi_(i l)^0
      )
    )
    = sum_(k in cal(L)) text(
       fill: #red,
      pi_(i k | i)^(0)
    )
    hat(phi)_(i k),
  $
where we have used @eqn:mA-commute-probability to substitute in $pi_(i k | i)^(0)$ (see the portions colored #text(red)[red]). From @eqn:mA-exact-hat-pi, we can then express the change in welfare
  $
    hat(U)_i = hat(Phi)_i^(1 / theta).
  $

We now combine @eqn:mA-exact-hat-clearing and @eqn:mA-exact-hat-pi to obtain
  $
    ((hat(A)_n) / hat(w)_n)^(1 / (1 - beta))
    &= [
      sum_(i in cal(L))
      (pi_(i n | i)^0 R_i^0 hat(R)_i (hat(w)_n slash hat(kappa)_(i n))^(theta)) /
      (sum_(k in cal(L)) pi_(i k | i)^(0) (hat(w)_k slash hat(kappa)_(i k))^(theta))
    ] 1 / L_n^0.
  $<eqn:mA-exact-hat-combined>
What does this characterization of a counterfactual equilibria buy us? If we express a counterfactual as a set of proportional changes to the parameter values ${hat(bold(A)), hat(bold(kappa)), hat(bold(R))}$, then we only need data on initial conditional commuting probabilities $bold(pi)^0$, workplace population $bold(L)^0$, and residential population $bold(R)^0$ to solve for the proportional changes in wages $hat(bold(w))$ (using @eqn:mA-exact-hat-combined) and conditional commuting probabilities $hat(bold(pi))$ (using @eqn:mA-exact-hat-pi).

Inspired by this representation, we define
  $
    cal(Z)_(n)(tilde(bold(w)))
    eq.def
    ((hat(A)_n) / tilde(w)_n)^(1 / (1 - beta))
    - [
      sum_(i in cal(L))
      (pi_(i n | i)^0 R_i^0 hat(R)_i (tilde(w)_n slash hat(kappa)_(i n))^(theta)) /
      (sum_(k in cal(L)) pi_(i k | i)^(0) (tilde(w)_k slash hat(kappa)_(i k))^(theta))
    ] 1 / L_n^0.
  $

We can use this vector-valued function $bold(cal(Z))(tilde(bold(w)))$ to compute the proportional changes in wages (and other equilibrium objects) in counterfactual equilibria. I provide pseudocode for this procedure below. I implement the algorithm in `analysis/qsm_implementation.ipynb`.

#stylebox[
  *Model A Algorithm:*
  + s = 0
  + $epsilon = "tolerance" + 1$
  + $tilde(bold(w))^0 = arrow(1)$
  + *while* $epsilon > "tolerance"$ *do*
  + #tab $tilde(bold(w))^(s + 1)$ = $tilde(bold(w))^s + kappa_w bold(cal(Z)) (tilde(bold(w))^s)$
  + #tab $epsilon = max {abs(bold(cal(Z)) (tilde(bold(w))^s))}$
  + #tab s = s + 1
  + *end while*
  + *return* $tilde(bold(w))^s$
]

As a word of caution, this model (and the model below) will rationalize a bilateral commuting flow of zero with an infinite commuting cost. The counterfactual exercises considered below will maintain this zero bilateral flow (even the counterfactual reduction in commuting costs).

== A Richer Model (Model B)
We now consider a model with a housing market and residential choice. The mass of agents is denoted $overline(R)$. We no longer fix an agent's residential location.

=== Setup
Utility for an agent $omega$ residing in location $i$ and working in location $n$ is given by
  $
    U_(i n omega)
    = (c_(i n omega) / alpha)^alpha (h_(i n omega) / (1 - alpha))^(1 - alpha) b_(i n omega) / kappa_(i n),
  $<eqn:mB-utility>
where $c_(i n omega)$ is final good consumption, $h_(i n omega)$ is housing consumption, and $F_(i n)(b_(i n omega)) &= exp(-B_(i n) b_(i n omega)^(-theta))$. We've added a parameter $B_(i n)$ that governs average utility for agents that live in location $i$ and work in location $n$. The Cobb-Douglas form of @eqn:mB-utility implies that agents spend a constant fraction $alpha$ of their income on the final good and $(1 - alpha)$ on housing. The price of the final good is again $1$, and we denote the price of housing in location $i$ by $q_i$. Accordingly, indirect utility for an agent $omega$ residing in location $i$ and working in location $n$ with wage $w_n$ is given by
  $
    cal(U)_(i n omega)
    = ((alpha w_n) / alpha)^alpha (((1 - alpha) w_n) / (q_i (1 - alpha)))^(1 - alpha) b_(i n omega) / kappa_(i n)
    = ((w_(n) q_i^(alpha - 1)) / kappa_(i n)) b_(i n omega).
  $
A worker $omega$ now chooses both a residence and workplace:
  $
    {i, n}_(omega)^(*) eq.def arg max_(i,n in cal(L)) cal(U)_(i n omega).
  $
Now, the Fréchet-distributed preference shock implies the following expression for the _unconditional_ residential and commuting probabilities
  $
    pi_(i n) & eq.def PP{{i, n}^(*) = {i, n}}
    = phi_(i n) Phi^(-1), \
    "where"quad
    phi_(i n) &eq.def B_(i n)((w_n q_i^(alpha - 1)) / kappa_(i n))^(theta) \
    "and"quad
    Phi &eq.def sum_(k in cal(L)) sum_(l in cal(L)) phi_(k l).
  $<eqn:mB-pi>
In what follows, it will be useful to define the mass of residents in each location $i$
  $
    R_i eq.def sum_(n in cal(L)) pi_(i n) overline(R),
  $
following the notation from Model A.

=== Housing Market
Each location $i$ has a fixed stock of land available for rent $H_i$. Landlords face no costs and spend all of their rental income on the final good to ensure goods market clearing. Let $overline(nu)_i$ denote the average income of residents in location $i$. We can than express _aggregate_ income for residents in location $i$
  $
    overline(nu)_i R_i &= sum_(n in cal(L)) pi_(i n) w_n overline(R).
  $<eqn:mB-agg-income>
Land market clearing implies that housing expenditure (given by utility maximization) must equal landlord income in neighborhood $i$:
  $
    underbrace((1 - alpha) overline(nu)_i R_i, "Housing Expenditure")
    &= underbrace(H_i q_i, "Landlord Income")
  $<eqn:mB-land-clearing>

=== Firms
We maintain the same set of assumptions on the firm side as in Model A. This yields the following wage equation and labor demand:
  $
    w_n &= beta A_n L_n^(beta - 1) \
    arrow.r.double.long
    L_n &= ((beta A_n) / w_n)^(1 / (1 - beta)).
  $<eqn:mB-wages>

// First, the unconditional commuting probability is

// $
//   pi_(i n | i)
//   = pi_(i n) / pi_(i)^R
//   = Phi_(i n) / (sum_(k in cal(L)) Phi_(i k))
//   = [w_n / kappa_(i n)]^(theta) / (sum_(k in cal(L)) [w_k / kappa_(i k)]^(theta))
// $

=== Commuting Equilibrium
We now use the unconditional commuting probability in @eqn:mB-pi to define the commuting market clearing condition:
  $
    L_n = sum_(i in cal(L)) pi_(i n) overline(R).
  $<eqn:mB-commuting-clearing>

We can now define the competitive equilibrium. Given the model parameters ${alpha, beta, theta}$, the residential population $overline(R)$, and the exogenous location characteristics ${bold(H), bold(A), bold(B), bold(kappa)}$, the equilibrium is a vector of quantities ${bold(L), bold(R)}$ and a vector of prices ${bold(w), bold(q)}$ that satisfy @eqn:mB-pi, @eqn:mB-agg-income, @eqn:mB-land-clearing, @eqn:mB-wages, and @eqn:mB-commuting-clearing.

Again, we can look to #cite(<alvarez_lucas_2007>, form: "prose") to establish conditions for the existence and uniqueness of the equilibrium.

=== Welfare
Given free residential mobility, utility is now equalized across space:
$
  U eq.def EE[cal(U)_({i n}^*_omega omega)] = Gamma(1 - 1 / theta) Phi^(1 / theta).
$
The derivation follows the same steps as in Model A.

=== Counterfactual Equilibria
We proceed as in model A and derive the exact hat system.
  $
    hat(phi)_(i n)
    &= hat(B)_(i n) ((hat(w)_n hat(q)_i^(alpha - 1)) / hat(kappa)_(i n))^theta \
    hat(pi)_(i n)
    // = (Phi_(i n)^0 hat(Phi)_(i n))
    // / (sum_(k in cal(L)) sum_(l in cal(L)) Phi_(k l)^0 hat(Phi)_(k l))
    &= (hat(phi)_(i n))
    / (sum_(k in cal(L)) sum_(l in cal(L)) pi_(k l)^0 hat(phi)_(k l)) \
    hat(R)_i
    &= (overline(R)^0 hat(overline(R))) / R_i^0 sum_(n in cal(L)) pi_(i n)^0 hat(pi)_(i n) \
    ((hat(A)_n) / hat(w)_n)^(1 / (1 - beta))
    &= ((overline(R)^0 hat(overline(R))) / L_n^0) sum_(i in cal(L)) pi_(i n)^0 hat(pi)_(i n) \
    hat(overline(nu))_i hat(R)_i
    &= hat(overline(R)) ((sum_(n in cal(L)) pi_(i n)^0 w_n^0 hat(pi)_(i n) hat(w)_n) / (sum_(k in cal(L)) pi_(i k)^0 w_k^0)) \
    hat(q)_i
    &= (hat(overline(nu))_i hat(R_i)) / hat(H)_i \
    hat(U)
    &= hat(Phi)^(1 / theta).
  $<eqn:mB-hat-system>
We combine the expressions from above and define
  $
    cal(Z)_(n)(tilde(bold(w)), tilde(bold(q)))
    &eq.def
    ((hat(A)_n) / hat(w)_n)^(1 / (1 - beta))
    - ((overline(R)^0 hat(overline(R))) / L_n^0) sum_(i in cal(L)) (pi_(i n)^0 hat(B)_(i n) (hat(w)_n hat(q)_i^(alpha - 1) slash hat(kappa)_(i n))^theta)
    / (sum_(k in cal(L)) sum_(l in cal(L)) pi_(k l)^0 hat(B)_(k l) (hat(w)_l hat(q)_k^(alpha - 1) slash hat(kappa)_(k l))^theta) \
    cal(Q)_(i)(tilde(bold(w)), tilde(bold(q)))
    &eq.def
    (hat(overline(R)) / hat(H)_i) ((sum_(n in cal(L)) pi_(i n)^0 w_n^0 hat(pi)_(i n) hat(w)_n) / (sum_(k in cal(L)) pi_(i k)^0 w_k^0)).
  $

  // CM: substitute in expression for hat(pi)_(i n)
  
#stylebox[
  *Model B Algorithm:*
  + s = 0
  + $epsilon = "tolerance" + 1$
  + $tilde(bold(w))^0 = tilde(bold(q))^0 = arrow(1)$
  + *while* $epsilon > "tolerance"$ *do*
  + #tab $tilde(bold(q))^(s + 1) = (1 - kappa_q) tilde(bold(q))^(s) + kappa_q bold(cal(Q))(tilde(bold(w))^(s), tilde(bold(q))^(s))$
  + #tab $tilde(bold(w))^(s + 1)$ = $tilde(bold(w))^s + kappa_w bold(cal(Z)) (tilde(bold(w))^s, tilde(bold(q))^s)$
  + #tab $epsilon = max {abs(bold(cal(Z)) (tilde(bold(w))^s, tilde(bold(q))^s))}$
  + #tab s = s + 1
  + *end while*
  + *return* $tilde(bold(w))^s, tilde(bold(q))^s$
]

= Data and Calibration
I measure commuting flows with the Longitudinal Employer-Household Dynamics (LEHD) Origin-Destination Employment Statistics (LODES).#footnote[Source: #link("https://lehd.ces.census.gov/data/")[Census].] We consider all jobs and restrict to workers who both live and work within the boundaries of Chicago. We use commuting flows from 2019 to remove any influence of the COVID-19 Pandemic. We aggregate the block-level commuting flows from LODES to the 77 neighborhoods of Chicago using community area boundaries from the City of Chicago.#footnote[Source: #link("https://data.cityofchicago.org/Facilities-Geographic-Boundaries/Boundaries-Community-Areas-current-/cauq-8yn6")[City of Chicago].] While the City of Chicago uses the term 'community area,' we refer to these units as 'neighborhoods.' We match block centroids to neighborhood boundaries. We can use these data to recover (un)conditional commuting probabilities and the workplace and residential population data required in our counterfactual simulations.#footnote[Please contact me if you would like the code to generate these data.]

Model B requires wages by workplace in the initial equilibrium. The LODES data report the proportion of jobs with monthly earnings (i) less than $\$1,250$ per month, (ii) $\$1,250$ to $\$3,333$ per month, and (iii) more than $\$3,333$ per month. We use 2019 ACS 5-year data from IPUMS to measure average monthly earnings in each of these wage bins.#footnote[Source: #link("https://usa.ipums.org/usa/index.shtml")[IPUMS]. It is important to note that we are abstracting away from any worker heterogeneity in these models.] We then calculate average wages by workplace using the proportions of jobs in each wage bin from LODES.

= Counterfactual Exercises
I compare the equilibrium impact of two parameter shocks: a 5% increase in productivity in the Far Southeast Side (FSE) and a 5% reduction in commuting costs from the FSE to Chicago's employment core, a contiguous region of 7 neighborhoods that hosts 67% of employment. I show these neighborhood clusters in @fig:shock-map. It is important to note that the $hat(bold(w))$ reports the changes in wages _paid_ to agents working in a given location.

#figure(caption: [Impacted Neighborhoods])[
  #image("out/shock_map.png", width: 50%)
]<fig:shock-map>

== Wages
I first report the change in wages paid by neighborhood in @fig:w-hat and @fig:w-hat-exclude; the latter excludes the far southeast for readability. The results are qualitatively and quantitatively similar for models A and B. The productivity shock substantially increases wages in the FSE. Other neighborhoods, especially those closest to the FSE, see small increases in wages, owing to a reduction in labor supplied to these neighborhoods.

The transport cost shock induces an increase in wages in the FSE and a decrease in wages in the employment core. Workers living in the FSE now have improved access to the employment core, leading to increased commuting from the FSE to the core. As a result of these labor supply changes, wages fall in the core and increase in the FSE.

#figure(caption: [$hat(bold(w))$, All Neighborhoods])[
  #stack(
    dir: ltr,
    image("out/w_hat_prod_mA.png", width: 50%),
    image("out/w_hat_prod_mB.png", width: 50%),
  )
  #stack(
    dir: ltr,
    image("out/w_hat_trans_mA.png", width: 50%),
    image("out/w_hat_trans_mB.png", width: 50%),
  )
]<fig:w-hat>

#figure(caption: [$hat(bold(w))$, Excluding Far Southeast])[
  #stack(
    dir: ltr,
    image("out/w_hat_prod_mA_exclude.png", width: 50%),
    image("out/w_hat_prod_mB_exclude.png", width: 50%),
  )
  #stack(
    dir: ltr,
    image("out/w_hat_trans_mA_exclude.png", width: 50%),
    image("out/w_hat_trans_mB_exclude.png", width: 50%),
  )
]<fig:w-hat-exclude>

== Rents
Next, I report changes in rents in @fig:q-hat and @fig:q-hat-exclude. We do not include rents in model A, so we only report results for model B. The productivity shock leads to smoother changes in rents across space than the transport cost shock. Under the productivity shock, residents can take advantage of increased wages in the FSE by moving to an adjacent neighborhood. However, with the transport cost shock, only FSE residents can access the transport cost reduction, creating a discontinuity in rent changes at the FSE border.

#figure(caption: [$hat(bold(q))$, All Neighborhoods])[
  #stack(
    dir: ltr,
    image("out/q_hat_prod_mB.png", width: 50%),
    image("out/q_hat_trans_mB.png", width: 50%),
  )
]<fig:q-hat>

#figure(caption: [$hat(bold(q))$, Excluding Far Southeast])[
  #stack(
    dir: ltr,
    image("out/q_hat_prod_mB_exclude.png", width: 50%),
    image("out/q_hat_trans_mB_exclude.png", width: 50%),
  )
]<fig:q-hat-exclude>

== Labor Supply
I plot changes in labor supply in @fig:L-hat and @fig:L-hat-exclude. In both models, the productivity shock produces a substantial increase in labor supplied to the FSE. Without residential resorting (model A), neighborhoods closer to but outside the FSE see larger reductions in labor supply than neighborhoods further away, since nearby residents have lower commuting costs to the FSE.

The transport cost shock reduces labor supplied to the FSE, as FSE residents now have better access to the employment core. This reduction is partially mitigated by increased labor supply to the FSE from adjacent neighborhoods.

#figure(caption: [$hat(bold(L))$, All Neighborhoods])[
  #stack(
    dir: ltr,
    image("out/L_hat_prod_mA.png", width: 50%),
    image("out/L_hat_prod_mB.png", width: 50%),
  )
  #stack(
    dir: ltr,
    image("out/L_hat_trans_mA.png", width: 50%),
    image("out/L_hat_trans_mB.png", width: 50%),
  )
]<fig:L-hat>

#figure(caption: [$hat(bold(L))$, Excluding Far Southeast])[
  #stack(
    dir: ltr,
    image("out/L_hat_prod_mA_exclude.png", width: 50%),
    image("out/L_hat_prod_mB_exclude.png", width: 50%),
  )
  #stack(
    dir: ltr,
    image("out/L_hat_trans_mA_exclude.png", width: 50%),
    image("out/L_hat_trans_mB_exclude.png", width: 50%),
  )
]<fig:L-hat-exclude>

== Residential Population
Since model B allows for changes in residential population, we report these changes in @fig:R-hat and @fig:R-hat-exclude. As described in the rents section, the productivity shock induces smoother changes in residential population.

#figure(caption: [$hat(bold(R))$, All Neighborhoods])[
  #stack(
    dir: ltr,
    image("out/R_hat_prod_mB.png", width: 50%),
    image("out/R_hat_trans_mB.png", width: 50%),
  )
]<fig:R-hat>

#figure(caption: [$hat(bold(R))$, Excluding Far Southeast])[
  #stack(
    dir: ltr,
    image("out/R_hat_prod_mB_exclude.png", width: 50%),
    image("out/R_hat_trans_mB_exclude.png", width: 50%),
  )
]<fig:R-hat-exclude>

== Welfare
Lastly, I report changes in welfare in @fig:U-hat and @fig:U-hat-exclude. Residential mobility (model B) guarantees utility equalization across space, so we see no spatial variation. Accordingly, I only report changes for model A. Again, the productivity shock produces a smoother gradient of utility changes, since nearby residents can take advantage of increased wages in the FSE. The transport cost shock yields a large discontinuity in utility changes at the FSE border. Residents in the employment core and adjacent neighborhoods see decreases in utility due to the increased labor supply to the employment core. Residents adjacent to the FSE see small increases in utility, as some residents can take advantage of reduced labor supply in the FSE.

#figure(caption: [$hat(bold(U))$, All Neighborhoods])[
  #stack(
    dir: ltr,
    image("out/U_hat_prod_mA.png", width: 50%),
    image("out/U_hat_trans_mA.png", width: 50%),
  )
]<fig:U-hat>

#figure(caption: [$hat(bold(U))$, Excluding Far Southeast])[
  #stack(
    dir: ltr,
    image("out/U_hat_prod_mA_exclude.png", width: 50%),
    image("out/U_hat_trans_mA_exclude.png", width: 50%),
  )
]<fig:U-hat-exclude>

#set par(
  leading: 1em,
  first-line-indent: 0em,
  justify: true,
)

// Model B:
// Productivity: 1.000783025244706
// Transportation: 1.0018882902521573

#bibliography(
    (
      "typst/ahlfeldt_ea_2015.bib",
      "typst/monte_ea_2018.bib",
      "typst/owens_ea_2020.bib",
      "typst/redding_rossi-hansberg_2017.bib",
      "typst/eaton_kortum_2002.bib",
      "typst/train_2003.bib",
      "typst/alvarez_lucas_2007.bib"
    ),
    style: "chicago-author-date"
)


/*----------------------------------------------------------
Move references with:
cp ~/projects/references/ahlfeldt_ea_2015.bib ~/projects/qsm-chicago/typst
cp ~/projects/references/monte_ea_2018.bib ~/projects/qsm-chicago/typst
cp ~/projects/references/owens_ea_2020.bib ~/projects/qsm-chicago/typst
cp ~/projects/references/redding_rossi-hansberg_2017.bib ~/projects/qsm-chicago/typst
cp ~/projects/references/eaton_kortum_2002.bib ~/projects/qsm-chicago/typst
cp ~/projects/references/train_2003.bib ~/projects/qsm-chicago/typst
cp ~/projects/references/alvarez_lucas_2007.bib ~/projects/qsm-chicago/typst
----------------------------------------------------------*/