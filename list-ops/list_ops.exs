defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l) do
    case l do
      [] -> 0
      [_|tail] -> 1 + count(tail)
    end
  end

  @spec reverse(list) :: list
  def reverse(l, aggregator \\ []) do
    case l do
      [] -> aggregator
      [head|tail] -> reverse(tail, [head|aggregator])
    end
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    case l do
      [] -> []
      [head|tail] -> [f.(head)|map(tail, f)]
    end
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    case l do
      [] -> []
      [head|tail] ->
        case f.(head) do
          true -> [head|filter(tail, f)]
          false -> filter(tail, f)
        end
    end
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce(l, aggregator, f) do
    case l do
      [] -> aggregator
      [head|tail] -> reduce(tail, f.(head, aggregator), f)
    end
  end

  @spec append(list, list) :: list
  def append(a, b) do
    case a do
      [] -> b
      [head|tail] -> [head|append(tail, b)]
    end
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    case ll do
      [] -> []
      [head|tail] -> 
        case tail do
          [] -> head
          [h|t] -> append(append(head, h), concat(t))
        end
    end
  end
end
