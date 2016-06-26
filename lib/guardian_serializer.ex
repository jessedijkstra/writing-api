defmodule Writing.GuardianSerializer do
  @behaviour Guardian.Serializer

  alias Writing.Repo
  alias Writing.User

  def for_token(user = %User{}), do: { :ok, "User:#{user.uuid}" }
  def for_token(_), do: { :error, "Unknown resource type" }

  def from_token("User:" <> uuid), do: { :ok, Repo.get(User, uuid) }
  def from_token(_), do: { :error, "Unknown resource type" }
end
