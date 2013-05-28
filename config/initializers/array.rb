class Array
  def random_take(hm)
    sort_by{ rand }.slice(0...hm)
  end

  def skip n
    slice n..(length - 1)
  end
end
