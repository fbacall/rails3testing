module RandomText
  def rand_word
    word = ""
    (3+rand(6)).times {|x| word << (97+rand(26)).chr}
    word
  end

  def rand_sent
    sent = ""
    (5+rand(10)).times {|x| sent << (rand_word + " ")}
    (sent.chop + ". ").capitalize
  end

  def rand_para
    para = ""
    (5+rand(10)).times {|x| para << rand_sent}
    para << "\n\n"
    para
  end
end