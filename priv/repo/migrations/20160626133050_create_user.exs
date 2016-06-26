defmodule Writing.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def up do
    create table(:users, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :email, :string
      add :password_hash, :string

      timestamps
    end

    # Force the e-mail address to be unique
    create index(:users, [:email], unique: true)
  end

  def down do
    drop table(:users)
  end
end
