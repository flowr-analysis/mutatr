% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mutatr.R
\name{generate_mutants}
\alias{generate_mutants}
\title{Generate n mutations for the given abstract syntax tree.}
\usage{
generate_mutants(
  asts,
  n,
  filter = function(...) TRUE,
  probabilities = list(),
  seed = NULL
)
}
\arguments{
\item{asts}{The abstract syntax trees to generate mutations for. Must be a named
lists with the name being the file path and the value being the abstract syntax tree.}

\item{n}{The number of mutations to generate.}

\item{filter}{A function that takes the mutation name, the source reference and the
file path and returns a boolean indicating whether the mutation can be applied.}

\item{probabilities}{A named list of probabilities for each mutation. If a mutation
is not in the list, the default probability is used.}

\item{seed}{The seed that determines what mutations are selected. If NULL, a random
seed is used.}
}
\value{
A list of n mutated abstract syntax trees with the applied mutation
}
\description{
Generate n mutations for the given abstract syntax tree.
}
