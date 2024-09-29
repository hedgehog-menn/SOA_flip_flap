# frozen_string_literal: true

# Module that can be included (mixin) to take and output TSV data
module TsvBuddy
  # Converts a String with TSV data into internal data structure @data
  # arguments: tsv - a String in TSV format
  # returns: nothing
  def take_tsv(tsv)
    rows = tsv.lines.map(&:chomp)
    header = rows[0].chomp.split("\t")
    @data = rows[1..].map do |line|
      values = line.chomp.split("\t")
      header.zip(values).to_h
    end
  end

  # Converts @data into tsv string
  # arguments: none
  # returns: String in TSV format
  def to_tsv
    header = @data.first.keys.join("\t")
    rows = @data.map { |row| row.values.join("\t") }
    rows.insert(0, header).reduce('') { |acc, element| "#{acc}#{element}\n" }
  end
end
