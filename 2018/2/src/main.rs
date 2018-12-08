use difference::{Changeset, Difference};
use std::fs;

fn part1(input: &str) -> usize {
  let mut total_twos = 0;
  let mut total_threes = 0;

  for l in input.lines() {
    let mut found_twos = false;
    let mut found_threes = false;

    for c in l.chars() {
      let occurrences = l.matches(c).count();

      if occurrences == 2 {
        found_twos = true;
      }
      if occurrences == 3 {
        found_threes = true;
      }
    }

    if found_twos {
      total_twos += 1;
    }

    if found_threes {
      total_threes += 1;
    }
  }

  total_twos * total_threes
}

fn part2(input: &str) -> String {
  for l in input.lines() {
    for l2 in input.lines() {
      let mut candidate = String::new();
      let mut possible = true;

      if l == l2 {
        continue;
      }

      let changeset = Changeset::new(l, l2, "");

      println!("{:?}", changeset.diffs);

      let mut adds = 0;
      let mut rems = 0;
      for seq in changeset.diffs {
        match seq {
          Difference::Same(ref x) => {
            candidate.push_str(x);
          }
          Difference::Add(ref x) => {
            if x.len() != 1 {
              possible = false;
            }
            adds += 1;
          }
          Difference::Rem(ref x) => {
            if x.len() != 1 {
              possible = false;
            }
            rems += 1;
          }
        }
      }

      if adds > 1 || rems > 1 {
        possible = false;
      }

      if possible {
        return candidate;
      }
    }
  }

  "".to_string()
}

fn main() {
  assert_eq!(
    part1("abcdef\nbababc\nabbcde\nabcccd\naabcdd\nabcdee\nababab"),
    12
  );
  assert_eq!(
    part2("abcde\nfghij\nklmno\npqrst\nfguij\naxcye\nwvxyz"),
    "fgij"
  );

  let contents = fs::read_to_string("input.txt");
  let input = contents.as_ref().unwrap();

  println!("part1: {}", part1(&input));
  println!("part2: {}", part2(&input));
}
