use std::fs;

fn captcha(numbers: Vec<u32>) -> (u32, u32) {
    let mut sum = (0, 0);

    let len = numbers.len();
    for i in 0..len {
        if numbers[i] == numbers[(i + 1) % len] {
            sum.0 += numbers[i]
        }

        if numbers[i] == numbers[(i + (len / 2)) % len] {
            sum.1 += numbers[i]
        }
    }

    return sum;
}

fn parse_input_string(input: &str) -> Vec<u32> {
    return input.chars().map(|c| c.to_digit(10)).flatten().collect()
}

fn main() {
    assert_eq!(captcha(parse_input_string("1122")).0, 3);
    assert_eq!(captcha(parse_input_string("1111")).0, 4);
    assert_eq!(captcha(parse_input_string("1234")).0, 0);
    assert_eq!(captcha(parse_input_string("91212129")).0, 9);

    assert_eq!(captcha(parse_input_string("1212")).1, 6);
    assert_eq!(captcha(parse_input_string("1221")).1, 0);
    assert_eq!(captcha(parse_input_string("123425")).1, 4);
    assert_eq!(captcha(parse_input_string("123123")).1, 12);
    assert_eq!(captcha(parse_input_string("12131415")).1, 4);

    let contents = fs::read_to_string("input.txt");
    let input = contents.as_ref().unwrap();

    println!("{:?}", captcha(parse_input_string(input)))
}
