{
  inputs,
  den,
  ...
}: {
  imports = [inputs.den.flakeModule];

  # Define a host with a user. Den will make the matching aspects
  # for both automatically
  den.hosts.x86_64-linux.coffee-machine.users.notroot = {};
}
