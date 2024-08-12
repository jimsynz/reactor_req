defimpl Reactor.Dsl.Build, for: Reactor.Req.Dsl.Request do
  @moduledoc false
  def build(req, reactor), do: Reactor.Req.Builder.build(req, :request, reactor)
  def verify(_, _), do: :ok
end
