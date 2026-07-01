{
  inputs,
  den,
  ...
}: {
  imports = [
    inputs.den.flakeModule
    inputs.den.flakeOutputs.packages
  ];

  # ANY Host or User aspect can produce outputs:
  # The flake-system-to-flake-os policy handles host fan-out.
  # To include aspects in flake outputs:
  # den.schema.flake-packages.includes = [ den.aspects.nvf ];

  # Define a host with a user. Den will make the matching aspects
  # for both automatically
  den.hosts.x86_64-linux.coffee-machine.users.notroot = {};
  den.homes.x86_64-linux."notroot@coffee-machine" = { };
}
