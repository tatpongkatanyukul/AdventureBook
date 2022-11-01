
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
