# CPE-390-Microprocessor-Systems
Assembly Language HCS12

## Rounding <br/>
When performing integer arithmetic (especially multiplication and division), 
it is important to keep track of potential size of results to avoid 
overflow and/or loss of precision

A better result would be to round the nearest integer 
round quotient = (divident + (divisor/2))/divisor

This effecively adds 0.5 to the answer before truncated. 
