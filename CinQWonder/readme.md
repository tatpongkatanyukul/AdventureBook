# การคำนวณในแดนมหัศจรรย์ควอนตัม (Computation in Quantum Wonderland)

See [what I have learned](https://github.com/tatpongkatanyukul/QC)

## Structure
* Chapter 1
  * What is Quantum Computing? What good will it do? How will it be achieved? (big picture) 
* Chapter 2
  * Quantum Mechanics and its classical counterpart
* Chapter 3
  
---

N & C: The postulates of quantum mechanics
* (p 80) **Postulate 1**: Associated to any isolated physical system is a complex vector space with inner product (that is, a Hilbert space) know as the _state space_ of the system. The system is completely described by its _state vector_, which is a unit vector in the system's state space.
* (p 81) **Postulate 2**: The evolution of a _closed_ quantum system is described by a _unitary transformation_. That is, the state $|\psi\rangle$ of the system at time $t_1$ is related to the state $|\psi'\rangle$ of the system at time $t_2$ by a unitary operator $U$ which depends only on the times $t_1$ adn $t_2$, $|\psi'\rangle = U |\psi\rangle$.
  * (p 82) ***Postulate 2'***: The time evolution of the state of a closed quantum system is described by the _Schrodinger equation_, $i \bar{h} \frac{d |\psi\rangle}{d t} = H |\psi\rangle$.
    * Imaginary number $i = \sqrt{-1}$; Planck's constant $\bar{h}$ must be experimentally determined; $H$ is a fixed Hermitian operator known as the _Hamiltonian_ of the closed system.
* (p 84) **Postulate 3**: Quantum measurements are described by a collection $\{M_m\}$ of _measurement operators_. These are operators acting on the state space of the system being measured. the index $m$ referfs to the measurement outcomes that may occur in the experiment. If the state of the quantum system is $|\psi\rangle$ immediately before the measurement then the probability that result $m$ occurs is given by $p(m) = \langle \psi | M_m^\dagger M_m | \psi \rangle$,
and the state of the system after the measurement is
$\frac{M_m | \psi \rangle }{\sqrt{\langle \psi | M_m^\dagger M_m | \psi \rangle}}$.
* (p 94) **Postulate 4**: The state space of a composite physical system is the tensor product of the state spaces of the component physical systems. Moreover, if we have systems numbered 1 through $n$, and system namer $i$ is prepared in the state $| \psi \rangle$, then the joint state of the total system is $| \psi_1 \rangle \otimes | \psi_2 \rangle \otimes \cdots \otimes | \psi_n \rangle$.


N & C: Linear operators and matrices

> "The most convenient way to understand linear operators is in terms of their _matrix representation_.
> In fact, the linear operator and matrix viewpoints turn out to be completely equivalent."

Suppose $A: V \rightarrow W$ is a linear operator between vector spaces $V$ and $W$. Suppose $|v_1 \rangle, \ldots, |v_m \rangle$ is a basis for $V$ and $|w_1 \rangle, \ldots, |w_n \rangle$ is a basis for $W$.
Then for each $j$ in the range $1, \ldots, m$, there exists complex  numbers $A_{ij}$ through $A_{nj}$, such that

$A|v_j \rangle = \sum_i A_{ij} |w_i \rangle$.

Example (Exercise 2.2). Suppose $V$ is a vector space with basis vectors $|0 \rangle$ and $|1 \rangle$,
and $A$ is a linear operator from $V$ to $V$ such that $A |0 \rangle = |1 \rangle$ and $A |1 \rangle = |0 \rangle$.
Give a matrix representation for $A$, with respect to the input basis $|0 \rangle$ , $|1 \rangle$, and the output basis $|0 \rangle$ , $|1 \rangle$. Find input and output bases which give rise to a different matrix representation of $A$.

Soln:

$A | 0 \rangle = A_{11} | 0 \rangle + A_{21} | 1 \rangle = | 1 \rangle$. Thus, $A_{11} = 0$, $A_{21} = 1$.

$A | 1 \rangle = A_{12} | 0 \rangle + A_{22} | 1 \rangle = | 0 \rangle$. Thus, $A_{12} = 1$, $A_{22} = 0$.

That is,
$A = [[0, 1], [1, 0]]$.
