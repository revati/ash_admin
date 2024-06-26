defmodule Demo.Repo.Migrations.MigrateResources6 do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_postgres.generate_migrations`
  """

  use Ecto.Migration

  def up do
    drop_if_exists(
      unique_index(:users, [:id, :first_name, :last_name],
        name: "users_representative_name_index"
      )
    )

    create(
      unique_index(:users, [:org, :first_name, :last_name],
        where: "representative = true",
        name: "users_representative_name_index"
      )
    )

    alter table(:tickets) do
      add(:metadata, :map)
    end
  end

  def down do
    alter table(:tickets) do
      remove(:metadata)
    end

    drop_if_exists(
      unique_index(:users, [:org, :first_name, :last_name],
        name: "users_representative_name_index"
      )
    )

    create(
      unique_index(:users, [:org, :first_name, :last_name],
        where: "representative = true",
        name: "users_representative_name_index"
      )
    )
  end
end
