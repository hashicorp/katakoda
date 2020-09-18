The card-number transformation used the built-in template for credit card numbers (`builtin/creditcardnumber`) which encode all digits.

## Challenge Scenario

Each credit card issuer has one or more issuer identification numbers (IIN) which the card number starts with. For example, American Express IIN is 34 and 37; therefore, if a credit card number was `3411 2222 3333 4444`, you can tell that it is an American Express card.

Your business only accepts American Express, MasterCard and Visa cards. The characteristics of these credit card numbers are:

| Card Issuer       | Starts with (IINs)        | Length        |
|-------------------|---------------------------|---------------|
| American Express  | 34, 37                    | 15 digits     |
| MasterCard        | 51, 52, 53, 54, 55        | 16 digits     |
| Visa              | 4                         | 16 digits     |

You wish to query the database periodically and count how many transactions were made with American Express cards, how many with MasterCards, and how many with Visa cards.


Create an FPE transformation that can satisfy your business requirements.

If you are not familiar with regex, refer to the [Regular Expression Quick Reference](http://regexrenamer.sourceforge.net/help/regex_quickref.html) to help define the pattern.


<br />

DO NOT FORGET to test your solution. You can add the transformations to the `payments` role, or create a new role.  

![](./assets/thinker.jpg)
