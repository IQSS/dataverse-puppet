# basename(string) : string
# basename(string[]) : string[]
#
# Returns the basename from the full path.
module Puppet::Parser::Functions

  newfunction(:basename, :type => :rvalue) do |args|
    if args[0].is_a?(Array)
      args.collect do |a| File.basename(a) end
    else
      File.basename(args[0])
    end
  end

  newfunction(:file_basename, :type => :rvalue) do |args|
    if args[0].is_a?(Array)
      args.collect do |a| File.basename(a, '.*') end
    else
      File.basename(args[0], '.*')
    end
  end

end