#!/bin/julia
using PrettyTables, Plots, Latexify, Unitful, UnitfulLatexify, LaTeXStrings, LsqFit, ColorSchemes
pgfplotsx()

years = [2010 2011 2012 2013 2014 2015 2018]
countries = LaTeXString.(["Qatar", "United States", "Singapore", "China"])
emissions = [
             40.7 41.2 44.6 37.8 45.4 39.4 38.2;
             17.4 17.0 16.3 16.3 16.5 16.3 16.1;
             11.0 8.7 6.8 10.3 10.3 9.3 9.7;
             6.6 7.2 7.4 7.6 7.5 7.7 8.0;
            ].*u"one";

colors = getindex.(get.(Ref(colorschemes), Symbol.("flag_", ["qa", "us", "sg", "cn"]), nothing), [1,3,1,1])
#colors = [
#          colorant"#6C1D45", # Qatar purple
#          colorant"#041E42", # US blue
#          colorant"#EF3340", # Singapore pale red?
#          #colorant"#C8102E", # China clear red
#          colorant"#FCE300", # China yellow
#         ]

@. model(x,p) = p[1]*(x-2010) + p[2] # Linear fit

p0 = [0.0,0.0]

fits = [curve_fit(model,vcat(years...),ustrip.(e),p0) for e in eachrow(emissions)]


set_default(unitformat=:siunitx,fmt="%.2g")


open("table.tex","w") do f
    pretty_table(f,
                 hcat(countries, emissions, first.(getproperty.(fits,:param)));
                 header=["Country", string.(years)..., "Growth / t/c./y"],
                 backend=Val(:latex), tf=tf_latex_booktabs,
                 #formatters = (v,i,j) -> LatexCell(latexify(v)),
                 wrap_table=false,
                )
end

pl = plot(
          years',
          emissions',
          label=hcat(countries...),
          color=reshape(colors, 1, :),
          xlabel=LaTeXString("Year"),
          ylabel=LaTeXString("Emissions / \\si{\\tonne\\per\\capita}"),
          st=:scatter,legend=:right,
          size=(400,300), ylim=(0,Inf),
         )
for k in eachindex(fits)
    f = fits[k]
    plot!(pl,x->model(x,f.param),color=colors[k],label=false, seriestype=:path)
end


savefig(pl, "figure.tikz")

