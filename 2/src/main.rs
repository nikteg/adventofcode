use std::fs;

fn spreadsheet(lines: Vec<Vec<u32>>) -> u32 {
    let mut sum = 0;

    for i in 0..lines.len() {
        let biggest = lines[i].iter().max().unwrap();
        let smallest = lines[i].iter().min().unwrap();
        sum += biggest - smallest;
    }

    return sum;
}

fn parse_input_string(input: &str) -> Vec<Vec<u32>> {
    return input.lines().map(|l| l.split("\t").map(|s| s.parse::<u32>()).flatten().collect()).collect()
}

fn main() {
    assert_eq!(spreadsheet(parse_input_string("5\t1\t9\t5
7\t5\t3
2\t4\t6\t8")), 18);

    let contents = fs::read_to_string("input.txt");
    let input = contents.as_ref().unwrap();

    println!("{:?}", spreadsheet(parse_input_string(input)))
}
