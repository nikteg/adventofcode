use regex::Regex;
use std::cmp::{max, min};
use std::collections::HashSet;
use std::fs;
use std::ptr;

#[derive(Debug, Eq, PartialEq)]
struct Claim {
  id: usize,
  x: isize,
  y: isize,
  w: isize,
  h: isize,
}

fn parse_line(line: &str) -> Claim {
  let re = Regex::new(r"#(\d+) @ (\d+),(\d+): (\d+)x(\d+)").unwrap();

  let capture = re.captures(line).unwrap();

  Claim {
    id: capture[1].parse().unwrap(),
    x: capture[2].parse().unwrap(),
    y: capture[3].parse().unwrap(),
    w: capture[4].parse().unwrap(),
    h: capture[5].parse().unwrap(),
  }
}

fn part1(input: &str) -> usize {
  let claims: Vec<Claim> = input.lines().map(|l| parse_line(l)).collect();
  let mut area = HashSet::<(isize, isize)>::new();

  for c in claims.iter() {
    for c2 in claims.iter() {
      if ptr::eq(c, c2) {
        continue;
      }

      let x = max(c.x, c2.x);
      let y = max(c.y, c2.y);
      let w = min(c.x + c.w - x, c2.x + c2.w - x);
      let h = min(c.y + c.h - y, c2.y + c2.h - y);

      for i in x..(x + w) {
        for j in y..(y + h) {
          area.insert((i, j));
        }
      }
    }
  }

  area.len()
}

fn part2(input: &str) -> usize {
  let claims: Vec<Claim> = input.lines().map(|l| parse_line(l)).collect();
  let mut clashes = HashSet::<usize>::new();

  for c in claims.iter() {
    for c2 in claims.iter() {
      if ptr::eq(c, c2) {
        continue;
      }

      let x = max(c.x, c2.x);
      let y = max(c.y, c2.y);
      let w = min(c.x + c.w - x, c2.x + c2.w - x);
      let h = min(c.y + c.h - y, c2.y + c2.h - y);

      if w > 0 && h > 0 {
        clashes.insert(c.id);
      }
    }
  }

  for c in claims.iter() {
    if !clashes.contains(&c.id) {
      return c.id;
    }
  }

  0
}

fn main() {
  assert_eq!(part1("#1 @ 1,3: 4x4\n#2 @ 3,1: 4x4\n#3 @ 5,5: 2x2"), 4);
  assert_eq!(part2("#1 @ 1,3: 4x4\n#2 @ 3,1: 4x4\n#3 @ 5,5: 2x2"), 3);

  let contents = fs::read_to_string("input.txt");
  let input = contents.as_ref().unwrap();

  println!("part1: {}", part1(&input));
  println!("part2: {}", part2(&input));
}
