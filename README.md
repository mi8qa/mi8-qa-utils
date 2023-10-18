# mi8-qa-utils
This project showcases a simplistic integration of RestAssured with the Allure Framework, enhanced by AspectJ. \
The primary objective here is to demonstrate the potential of moving away from the conventional annotation-based approach, steering towards utilizing the Domain Specific Language (DSL) that RestAssured offers.\
 Furthermore, this project explores the customization, retry mechanisms, and certain concealments in Allure, making the testing process more streamlined and adaptable.

## Recommended Repositories
These repositories might be beneficial for further enhancing or understanding the testing framework setup:

- [Rest assured Curl logger](https://github.com/dzieciou/curl-logger) - A handy tool for logging curl commands.
- [Allure-Rest-Assured library](https://github.com/allure-framework/allure-java/tree/master/allure-rest-assured) - A library to integrate RestAssured with Allure for better reporting.
- [RestAssured report templates for Allure](https://github.com/viclovsky/allure-java-templates-example) - Custom report templates for creating informative and visually appealing Allure reports.

## Feedback
I'm aware of some issues and it's probably not a good decision to use this library. \
But I'll try keep it going with further implementation.\
Anyways, feel free to open an issue or submit a pull request if you have any suggestions, improvements, or bug reports.\
Your contributions are highly welcomed!

## Usage & Examples
- [Here's a simple tests examples](src/test/java/io/github/mi8qa/tests/FeatureTests.java)
![Allure report](allure_example.gif)

And the execution is pretty the same but you can design your tests as you wish with more flexibility and less code :)
![Test execution](execution_example.gif)
