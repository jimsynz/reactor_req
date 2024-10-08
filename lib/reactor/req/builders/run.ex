defimpl Reactor.Dsl.Build, for: Reactor.Req.Dsl.Run do
  @moduledoc false
  def build(req, reactor), do: Reactor.Req.Builder.build(req, :run, reactor)
  def verify(_, _), do: :ok
end
