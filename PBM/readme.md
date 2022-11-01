
# การผจญภัยของแบบจำลองพลวัต (The Adventures of Dynamic Modeling)

* Old english title: "The Adventures of Computation in the World of Physically-Based Modeling"
* title: การผจญภัยของแบบจำลองเชิงกายภาพ "The Adventures of Computation in Physically-Based Modeling"
  * It is more concise

* Alternative: **Physically-based modeling and dynamic simulation** แบบจำลองเชิงกายภาพและการจำลองพลวัตร
* Alternative: การผจญภัยของแบบจำลองเชิงกายภาพ (The Adventures of Physically-Based Modeling)

## Structures
  * Chapter 1: Introduction
    * What is physically-based modeling? and what is it for? How is it done? (big picture)
  
## Domains

### Solid

### Fluid

### Heat

### Electromagnetism

### Biology

#### Morphogen gradient

Ortrud Wartlick, Anna Kicheva, and Marcos González-Gaitán, Morphogen Gradient Formation. Cold Spring Harb Perspect Biol. 2009 Sep; 1(3)

> "According to this model[Wolpert 1969], morphogen is secreted from a group of of source cells and forms a gradient of concentration in the target tissue. Different target genes are expressed above distinct concentration thresholds, i.e., at different distances to the source, hence generatign a spatial pattern of gene expression. ... Experiments in the 1970s and later confirmed that tissues are patterned by morphogen gradients."
> "The most definitive example of a morphogen was provided with the identification of Bicoid function in the Drosophila embryo (Nuesslein teams in 1980s) ..."
 

Morphogen spreading can be described with an effective diffusion coefficient $D$ (in $\mu m^2/s$) and effective dddegradation rate $k$ (in $1/s$):

$\frac{\partial c}{\partial t} = D \frac{\partial^2 c}{\partial x^2} - k c$

where the morphogen concentration $c$ (in molecules/$\mu m^3$) is a function of space and time, i.e., $c(x,t)$.

Sometimes, instead of the degradation rate $k$, the half-life of molecule $\tau$ (in second) is used. This is the time after which the concentration has been reduced by half from the degradation effect alone:
$\frac{1}{2} c_0 = c_0 e^{-k \tau}$.

That is, $k = \frac{1}{\tau} \log 2$.

**Example**

> "The gradient of Decapentaplegic (Dpp) and Wingless (Wg) in _Drosophila_ imaginal discs, and Bicoid in the embryo have been analyzed considering effective diffusion and lienar degradation (Gregor et al. 2007; Kicheva et al. 2007). ... [the kinetic parameters of Dpp spreading] are consistent with the timescale of steady-state gradient formation (~8h). "

[**Kicheva et al., Kinetics of morphogen gradient formation. Science. 2007 Jan 26;315(5811):521-5**](https://github.com/tatpongkatanyukul/AdventureBook/blob/main/PBM/raw/Kicheva_Science_2007.pdf)

> "Dpp is produced at the anterior-posterior compartment boundary in the center of the wing imaginal disc of _Drosophila_(8). Dpp spreads nondirectionally, is degraded while spreading, and forms a gradient of concentration in the plane of the wing epithelim. Regardless of the actual transport mechanism, these facts imply that Dpp spreading can be captured by the physics of molecules that are producted in localized source, which generates a currrent $j_0$ [molecules/($\mu m \times s)] at the source boundary; that are degraded with a rate $k$ ($s^{-1}$); and that spread in a nondirectional manner with an effective diffusion coefficient $D$ ($\mu m^2/s$)". Thus, the rate of change of Dpp concentration in the $x-y$ plane, $C(x,y,t)$, is descript by the equation:"
> $\partial_t C = D \nabla^2 C - k C + 2 j_0 \delta(x)$ (1)
> where $t$ is time, $x > 0$ is the distance to the source in the target tissue, $\nabla^2$ is the Laplace operator, and $\delta$ is the Dirac delta function.
> The steady-staet solution for Eq. 1 is a single exponential gradient:
> $ C(x) = C_0 e^{-x/\lambda}$
> where the Dpp concentration $C(x)$ depends only on the distance $x$ from the source, the concentration $C_0$ at the source boundary, and the decay lenght $\lambda$.
> ... $\lambda = \sqrt{D/k}$
> ... $C_0 = j_0 / \sqrt{D/k}$
> ... a decay length $\lambda$ = 20.2 $\pm$ 5.7 $\mu m$, ...
>  


