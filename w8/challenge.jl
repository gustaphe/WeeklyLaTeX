#!/bin/julia
using PrettyTables, Plots, Latexify, Unitful, UnitfulLatexify, LaTeXStrings
pgfplotsx()

years = [2010 2011 2012 2013 2014 2015 2018]
countries = LaTeXString.(["Qatar", "United States", "Singapore", "China"])
emissions = [
             40.7 41.2 44.6 37.8 45.4 39.4 38.2;
             17.4 17.0 16.3 16.3 16.5 16.3 16.1;
             11.0 8.7 6.8 10.3 10.3 9.3 9.7;
             6.6 7.2 7.4 7.6 7.5 7.7 8.0;
            ].*u"one";
open("table.tex","w") do f
    pretty_table(f,
                 hcat(countries, emissions),hcat("Country",string.(years)),
                 backend=:latex,tf=tf_latex_booktabs,
                 formatters = (v,i,j) -> latexify(v;unitformat=:siunitx),
                 wrap_table=false,
                )
end

savefig(plot(
             years',
             emissions',
             label=hcat(countries...),
             xlabel=LaTeXString("Year"),
             ylabel=LaTeXString("Emissions / \\si{\\tonne}"),
             st=:scatter,legend=:right,
             size=(400,300), ylim=(0,Inf),
            ),
        "figure.tikz")

