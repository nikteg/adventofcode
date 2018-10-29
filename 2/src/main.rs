use std::cmp;
use std::fs;

fn spreadsheet(lines: Vec<Vec<u32>>) -> (u32, u32) {
    let mut sum = (0, 0);

    for i in 0..lines.len() {
        let biggest = lines[i].iter().max().unwrap();
        let smallest = lines[i].iter().min().unwrap();

        sum.0 += biggest - smallest;

        for j in 0..lines[i].len() {
            for k in (j + 1)..lines[i].len() {
                let biggest = cmp::max(lines[i][j], lines[i][k]);
                let smallest = cmp::min(lines[i][j], lines[i][k]);

                if biggest % smallest == 0 {
                    sum.1 += biggest / smallest;
                }
            }
        }
    }

    sum
}

fn parse_input_string(input: &str) -> Vec<Vec<u32>> {
    input
        .lines()
        .map(|l| l.split("\t").map(|s| s.parse::<u32>()).flatten().collect())
        .collect()
}

fn main() {
    assert_eq!(
        spreadsheet(parse_input_string("5\t1\t9\t5\n7\t5\t3\n2\t4\t6\t8")).0,
        18
    );

    assert_eq!(
        spreadsheet(parse_input_string("5\t9\t2\t8\n9\t4\t7\t3\n3\t8\t6\t5")).1,
        9
    );

    let contents = fs::read_to_string("input.txt");
    let input = contents.as_ref().unwrap();

    println!("{:?}", spreadsheet(parse_input_string(input)))
}
