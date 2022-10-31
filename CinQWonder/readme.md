# การคำนวณในแดนมหัศจรรย์ควอนตัม (Computation in Quantum Wonderland)

See [what I have learned](https://github.com/tatpongkatanyukul/QC)

## Structure
* Chapter 1
  * What is Quantum Computing? What good will it do? How will it be achieved? (big picture) 
* Chapter 2
  * Quantum Mechanics and its classical counterpart
* Chapter 3
  
---

N & C:
Postulates
* (p 80) **Postulate 1**: Associated to any isolated physical system is a complex vector space with inner product (that is, a Hilbert space) know as the _state space_ of the system. The system is completely described by its _state vector_, which is a unit vector in the system's state space.
* (p 81) **Postulate 2**: The evolution of a _closed_ quantum system is described by a _unitary transformation_. That is, the state $|\psi\rangle$ of the system at time $t_1$ is related to the state $|\psi'\rangle$ of the system at time $t_2$ by a unitary operator $U$ which depends only on the times $t_1$ adn $t_2$, $|\psi'\rangle = U |\psi\rangle$.
  * (p 82) ***Postulate 2'***: The time evolution of the state of a closed quantum system is described by the _Schrodinger equation_, $i \bar{h} \frac{d |\psi\rangle}{d t} = H |\psi\rangle$.
    * Imaginary number $i = \sqrt{-1}$; Planck's constant $\bar{h}$ must be experimentally determined; $H$ is a fixed Hermitian operator known as the _Hamiltonian_ of the closed system.
* (p 84) **Postulate 3**: Quantum measurements are described by a collection $\{M_m\}$ of _measurement operators_. These are operators acting on the state space of the system being measured. the index $m$ referfs to the measurement outcomes that may occur in the experiment. If the state of the quantum system is $|\psi\rangle$ immediately before the measurement then the probability that result $m$ occurs is given by $p(m) = \langle \psi | M_m\dag$ 

