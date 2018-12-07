use std::collections::HashSet;
use std::fs;

fn resulting_freq(numbers: &[isize]) -> isize {
  numbers.iter().sum()
}

fn resulting_cycled_freq(numbers: &[isize]) -> Result<isize, ()> {
  let mut seen = HashSet::new();
  seen.insert(0);

  let mut freq = 0;
  for n in numbers.iter().cycle() {
    freq += n;
    // println!("acc is {} after adding {}", freq, n);

    if seen.contains(&freq) {
      return Ok(freq);
    }

    seen.insert(freq);
  }

  Err(())
}

fn parse_input_string(input: &str) -> Vec<isize> {
  input
    .lines()
    .filter_map(|s| s.parse::<isize>().ok())
    .collect()
}

fn main() {
  assert_eq!(resulting_freq(&vec![1, 1, 1]), 3);
  assert_eq!(resulting_freq(&vec![1, 1, -2]), 0);
  assert_eq!(resulting_freq(&vec![-1, -2, -3]), -6);

  assert_eq!(resulting_cycled_freq(&vec![1, -1]).unwrap(), 0);
  assert_eq!(resulting_cycled_freq(&vec![3, 3, 4, -2, -4]).unwrap(), 10);
  assert_eq!(resulting_cycled_freq(&vec![-6, 3, 8, 5, -6]).unwrap(), 5);
  assert_eq!(resulting_cycled_freq(&vec![7, 7, -2, -7, -4]).unwrap(), 14);

  let contents = fs::read_to_string("input.txt");
  let input = contents.as_ref().unwrap();

  let numbers = parse_input_string(&input);
  println!("resulting freq: {}", resulting_freq(&numbers));
  println!(
    "resulting cycled freq: {}",
    resulting_cycled_freq(&numbers).unwrap()
  );
}
