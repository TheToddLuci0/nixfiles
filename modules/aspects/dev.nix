{ den, ... }:
{
  den.aspects.dev = {
    includes = [
      den.aspects.direnv
    ];
  };
}
