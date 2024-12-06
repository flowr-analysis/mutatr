find_applicable_mutations <- function(ast) {
  muts <- list()
  for (key in names(mutations)) {
    muts[[key]] <- c()
  }
  visitor <- list(
    exprlist = function(es, v, ...) lapply(es, visit, v, roles$ExprList),
    pairlist = function(l, v, ...) lapply(l, visit, v, roles$PairList),
    atomic = function(a, v, r) {
      for (m in all_applicable(a, r)) {
        new_mut <- rlang::hash(a)
        muts[[m]] <<- append(muts[[m]], list(new_mut))
      }
    },
    name = function(n, v, r) {
      for (m in all_applicable(n, r)) {
        new_mut <- rlang::hash(n)
        muts[[m]] <<- append(muts[[m]], list(new_mut))
      }
    },
    call = function(cl, v, r) {
      for (m in all_applicable(cl, r)) {
        new_mut <- rlang::hash(cl)
        muts[[m]] <<- append(muts[[m]], list(new_mut))
      }

      parts <- split_up_call(cl)
      f <- parts$name
      as <- parts$args

      visit(f, v, roles$FunName)
      arg_role <- switch(name_as_string(f),
        "while" = roles$Cond,
        "if" = roles$Cond,
        "return" = roles$Ret,
        roles$Arg
      )
      lapply(as, visit, v, arg_role)
    }
  )

  visit(ast, visitor, roles$Root)
  return(muts)
}
