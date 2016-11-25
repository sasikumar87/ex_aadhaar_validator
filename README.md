# AadhaarValidator

An Elixir library to verify if the given number is a valid Aadhaar number issued by Unique Identification Authority of India.
It follows [Verhoeff_algorithm](https://en.wikipedia.org/wiki/Verhoeff_algorithm).

## Installation

This library can be installed as:

  Add `aadhaar_validator` to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
    [{:aadhaar_validator, git: "https://github.com/sasikumar87/ex_aadhaar_validator.git"}]
  end
  ```

## Usage

  Check if a given string is a valid Aadhaar number by passing either string or number.
  ```elixir
    iex(1)> AadhaarValidator.valid?("123456789109")
    true
    iex(2)> AadhaarValidator.valid?(123456789109)
    true
  ```

  Also find the checksum given the valid input.
  ```elixir
  iex(1)> AadhaarValidator.checksum_of("12345678910")
  "9"
  iex(2)> AadhaarValidator.checksum_of(12345678910)
  9
  ```
