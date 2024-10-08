defimpl Reactor.Dsl.Build, for: Reactor.Req.Dsl.Post do
  @moduledoc false
  def build(req, reactor), do: Reactor.Req.Builder.build(req, :post, reactor)
  def verify(_, _), do: :ok
end
