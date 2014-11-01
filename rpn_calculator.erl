%% 逆ポーランド記法電卓 (関数型スタイル)

-module(rpn_calculator).
-export([calculate/1]).
-export([main/0]).

calculate(Rpn) ->
  Calc = fun
    Calc(Stack, []) ->
      hd(Stack);
    Calc(Stack, [X|Xs]) ->
      case re:run(X, "^[0-9]+$") of
        {match, _} ->
          Calc([list_to_integer(X) | Stack], Xs);
        _ ->
          case Stack of
            [Y1,Y2|Ys] ->
              OpeFn = ope_fn(X),
              Calc([OpeFn(Y2, Y1) | Ys], Xs)
          end
      end
  end,
  Expr = string:tokens(Rpn, " "),
  Calc([], Expr).

ope_fn("+") ->
  fun(X, Y) -> X + Y end;
ope_fn("-") ->
  fun(X, Y) -> X - Y end;
ope_fn("*") ->
  fun(X, Y) -> X * Y end;
ope_fn("/") ->
  fun(X, Y) -> X / Y end;
ope_fn(Ope) ->
  error("unsupported operator '" ++ Ope ++ "' is used").

%% 利用例
main() ->
  Rpn = "1 2 + 3 / 4 - 5 *",
  io:format("~s~n = ~p~n", [Rpn, calculate(Rpn)]).
