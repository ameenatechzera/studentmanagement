import 'package:flutter/material.dart';

class NotesExpansionScreen extends StatelessWidget {
  const NotesExpansionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chapter 1 :Number System')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: const Text('''
Numbers are used for counting, measuring, and calculating.
In Class 9, we mainly study Real Numbers.

(a) Natural Numbers (ℕ)
Numbers starting from 1
Example: 1, 2, 3, 4, …

(b) Whole Numbers (𝕎)
Natural numbers + 0
Example: 0, 1, 2, 3, …

(c) Integers (ℤ)
Positive numbers, negative numbers, and zero
Example: −3, −2, −1, 0, 1, 2, 3

(d) Rational Numbers (ℚ)
Numbers that can be written in the form p/q, where q ≠ 0
Example:
1/2, −3/4, 0.5, 2
Terminating and recurring decimals are rational

(e) Irrational Numbers
Numbers that cannot be written as p/q
Decimal expansion is non-terminating and non-recurring
Example:
√2, √3, π

(f) Real Numbers (ℝ)
All rational + irrational numbers
Represented on the number line

3️⃣ Representation of Real Numbers on Number Line
Every real number has a unique position
Irrational numbers (like √2) can be located using geometrical method

4️⃣ Properties of Real Numbers

Closure Property  
Addition & multiplication of real numbers gives a real number  

Commutative Property  
a + b = b + a  
a × b = b × a  

Associative Property  
(a + b) + c = a + (b + c)  

Distributive Property  
a × (b + c) = ab + ac  

5️⃣ Laws of Exponents (Important ⭐)

For any real number a, b and integers m, n:  
aᵐ × aⁿ = aᵐ⁺ⁿ  
aᵐ / aⁿ = aᵐ⁻ⁿ (a ≠ 0)  
(aᵐ)ⁿ = aᵐⁿ  
(ab)ᵐ = aᵐbᵐ  
a⁰ = 1 (a ≠ 0)

6️⃣ Decimal Expansion of Rational Numbers

Terminating decimal → denominator has only 2 or 5  
Non-terminating recurring → denominator has other prime factors  

Example:  
1/8 = 0.125 (terminating)  
1/3 = 0.333… (recurring)

7️⃣ Important Examples

√4 = 2 → Rational  
√5 → Irrational  
0.25 = 1/4 → Rational
''', style: TextStyle(fontSize: 15, height: 1.6, color: Colors.black87)),
      ),
    );
  }
}
