/* Remembering the basics of C programming - get closer to bare metal
 * Preprocessors, compile and running, main
 * |> gcc -g hello.c -o build/hello
 */

/* Entrypoint to the program
 * @param[in] argc: number of arguments, 0 is the program name
 * @param[in] **argv: actual arguments, pointer=>poitner=>char
 * @param[out]   _: int, status code, 0 is success
 */

#include <stdio.h>
#define PI 3.14159


double circle_area(double radius) {
    return PI * radius * radius;
}

double miles_yards_to_km(int miles, int yards) {
    // keep in mind that int / int = 0
    return 1.609 * (miles + yards / 1760.0);
}

double farenheit_to_celsius(int farenheit) {
    return (farenheit - 32) / 1.8;
}

int main(void) {
    printf("~~~~~Some trivial IO and functions~~~~~\n");

    // area of the circle
    double area = 0.0, radius = 0.0;
    printf("Enter the radius:\n"); // the prompt
    scanf("%lf", &radius);
    area = circle_area(radius);
    printf("area(radius=%lf [m]) -> %lf[m^2]\n", radius, area);

    // convert miles and yards to km
    int miles = 0, yards = 0;
    double km;
    printf("Input the miles and yards:\n");
    scanf("%d%d", &miles, &yards);
    km = miles_yards_to_km(miles, yards);
    printf("%d miles and %d yards is %lf km\n", miles, yards, km);

    // some more conversions
    int farenheit = 60;
    double deg_celsius = farenheit_to_celsius(farenheit);
    printf("%d Farenheit is %lf Celsius degrees\n", farenheit, deg_celsius);
    return 0;
}