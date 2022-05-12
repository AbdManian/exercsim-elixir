defmodule RationalNumbers do
  @type rational :: {integer, integer}

  defp reduce(a, b) when b < 0, do: reduce(-a, -b)

  defp reduce(a, b) do
    gcd = Integer.gcd(a, b)
    {div(a, gcd), div(b, gcd)}
  end

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({a1, b1}, {a2, b2}) do
    a = a1 * b2 + a2 * b1
    b = b1 * b2
    reduce(a, b)
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({a1, b1}, {a2, b2}) do
    add({a1, b1}, {-a2, b2})
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({a1, b1}, {a2, b2}) do
    a = a1 * a2
    b = b1 * b2
    reduce(a, b)
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by({a1, b1}, {a2, b2}) do
    a = a1 * b2
    b = b1 * a2
    reduce(a, b)
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs({a, b}) do
    reduce(Kernel.abs(a), Kernel.abs(b))
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational({a, b}, n) do
    if n >= 0 do
      reduce(a ** n, b ** n)
    else
      reduce(b ** -n, a ** -n)
    end
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, {a, b}) do
    x ** (a / b)
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce({a, b}) do
    reduce(a, b)
  end
end
