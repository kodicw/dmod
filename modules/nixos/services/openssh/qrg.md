NixOS Options
────────────────────
# services.openssh.extraConfig
Verbatim contents of {file}`sshd_config`.
type: strings concatenated with "\n"


NixOS Options
────────────────────
# services.openssh.knownHosts.<name>.publicKey
The public key data for the host. You can fetch a public key
from a running SSH server with the {command}`ssh-keyscan`
command. The public key should not include any host names, only
the key type and the key itself.

type: null or string


NixOS Options
────────────────────
# services.openssh.settings.PasswordAuthentication
Specifies whether password authentication is allowed.

type: boolean


NixOS Options
────────────────────
# services.openssh.knownHosts.<name>.extraHostNames
A list of additional host names and/or IP numbers used for
accessing the host's ssh service. This list is ignored if
`hostNames` is set explicitly.

type: list of string


NixOS Options
────────────────────
# services.openssh.sftpServerExecutable
The sftp server executable.  Can be a path or "internal-sftp" to use
the sftp server built into the sshd binary.

type: string


NixOS Options
────────────────────
# services.openssh.settings.AllowGroups
If specified, login is allowed only for users part of the
listed groups.
See {manpage}`sshd_config(5)` for details.

type: null or (list of string)


NixOS Options
────────────────────
# services.openssh.listenAddresses
List of addresses and ports to listen on (ListenAddress directive
in config). If port is not specified for address sshd will listen
on all ports specified by `ports` option.
NOTE: this will override default listening on all local addresses and port 22.
NOTE: setting this option won't automatically enable given ports
in firewall configuration.

type: list of (submodule)


NixOS Options
────────────────────
# services.openssh.settings.Ciphers
Allowed ciphers

Defaults to recommended settings from both
<https://stribika.github.io/2015/01/04/secure-secure-shell.html>
and
<https://infosec.mozilla.org/guidelines/openssh#modern-openssh-67>

type: list of string


NixOS Options
────────────────────
# services.openssh.settings.GatewayPorts
Specifies whether remote hosts are allowed to connect to
ports forwarded for the client.  See
{manpage}`sshd_config(5)`.

type: string


NixOS Options
────────────────────
# services.openssh.settings.StrictModes
Whether sshd should check file modes and ownership of directories

type: boolean


NixOS Options
────────────────────
# services.openssh.authorizedKeysCommandUser
Specifies the user under whose account the AuthorizedKeysCommand
is run. It is recommended to use a dedicated user that has no
other role on the host than running authorized keys commands.

type: string


NixOS Options
────────────────────
# services.openssh.settings.KbdInteractiveAuthentication
Specifies whether keyboard-interactive authentication is allowed.

type: boolean


NixOS Options
────────────────────
# services.openssh.knownHosts.<name>.publicKeyFile
The path to the public key file for the host. The public
key file is read at build time and saved in the Nix store.
You can fetch a public key file from a running SSH server
with the {command}`ssh-keyscan` command. The content
of the file should follow the same format as described for
the `publicKey` option. Only a single key
is supported. If a host has multiple keys, use
{option}`programs.ssh.knownHostsFiles` instead.

type: null or path


NixOS Options
────────────────────
# services.openssh.authorizedKeysFiles
Specify the rules for which files to read on the host.

This is an advanced option. If you're looking to configure user
keys, you can generally use [](#opt-users.users._name_.openssh.authorizedKeys.keys)
or [](#opt-users.users._name_.openssh.authorizedKeys.keyFiles).

These are paths relative to the host root file system or home
directories and they are subject to certain token expansion rules.
See AuthorizedKeysFile in man sshd_config for details.

type: list of string


NixOS Options
────────────────────
# services.openssh.sftpFlags
Commandline flags to add to sftp-server.

type: list of string


NixOS Options
────────────────────
# services.openssh.hostKeys
NixOS can automatically generate SSH host keys.  This option
specifies the path, type and size of each key.  See
{manpage}`ssh-keygen(1)` for supported types
and sizes.

type: list of (attribute set)


NixOS Options
────────────────────
# services.openssh.settings.UseDns
Specifies whether sshd(8) should look up the remote host name, and to check that the resolved host name for
the remote IP address maps back to the very same IP address.
If this option is set to no (the default) then only addresses and not host names may be used in
~/.ssh/authorized_keys from and sshd_config Match Host directives.

type: boolean


NixOS Options
────────────────────
# services.openssh.knownHosts
Alias of {option}`programs.ssh.knownHosts`.
type: attribute set of (submodule)


NixOS Options
────────────────────
# services.openssh.banner
Message to display to the remote user before authentication is allowed.

type: null or strings concatenated with "\n"


NixOS Options
────────────────────
# services.openssh.settings
Configuration for `sshd_config(5)`.
type: attribute set of (atom (null, bool, int, float or string))


NixOS Options
────────────────────
# services.openssh.ports
Specifies on which ports the SSH daemon listens.

type: list of 16 bit unsigned integer; between 0 and 65535 (both inclusive)


NixOS Options
────────────────────
# services.openssh.openFirewall
Whether to automatically open the specified ports in the firewall.

type: boolean


NixOS Options
────────────────────
# services.openssh.listenAddresses.*.addr
Host, IPv4 or IPv6 address to listen to.

type: null or string


NixOS Options
────────────────────
# services.openssh.authorizedKeysCommand
Specifies a program to be used to look up the user's public
keys. The program must be owned by root, not writable by group
or others and specified by an absolute path.

type: string


NixOS Options
────────────────────
# services.openssh.settings.LogLevel
Gives the verbosity level that is used when logging messages from sshd(8). Logging with a DEBUG level
violates the privacy of users and is not recommended.

type: one of "QUIET", "FATAL", "ERROR", "INFO", "VERBOSE", "DEBUG", "DEBUG1", "DEBUG2", "DEBUG3"


NixOS Options
────────────────────
# services.openssh.enable
Whether to enable the OpenSSH secure shell daemon, which
allows secure remote logins.

type: boolean


NixOS Options
────────────────────
# services.openssh.settings.AuthorizedPrincipalsFile
Specifies a file that lists principal names that are accepted for certificate authentication. The default
is `"none"`, i.e. not to use	a principals file.

type: string


NixOS Options
────────────────────
# services.openssh.settings.Macs
Allowed MACs

Defaults to recommended settings from both
<https://stribika.github.io/2015/01/04/secure-secure-shell.html>
and
<https://infosec.mozilla.org/guidelines/openssh#modern-openssh-67>

type: list of string


NixOS Options
────────────────────
# services.openssh.settings.DenyGroups
If specified, login is denied for all users part of the listed
groups. Takes precedence over
[](#opt-services.openssh.settings.AllowGroups). See
{manpage}`sshd_config(5)` for details.

type: null or (list of string)


NixOS Options
────────────────────
# services.openssh.listenAddresses.*.port
Port to listen to.

type: null or signed integer


NixOS Options
────────────────────
# services.openssh.allowSFTP
Whether to enable the SFTP subsystem in the SSH daemon.  This
enables the use of commands such as {command}`sftp` and
{command}`sshfs`.

type: boolean


NixOS Options
────────────────────
# services.openssh.settings.X11Forwarding
Whether to allow X11 connections to be forwarded.

type: boolean


NixOS Options
────────────────────
# services.openssh.knownHosts.<name>.hostNames
A list of host names and/or IP numbers used for accessing
the host's ssh service. This list includes the name of the
containing `knownHosts` attribute by default
for convenience. If you wish to configure multiple host keys
for the same host use multiple `knownHosts`
entries with different attribute names and the same
`hostNames` list.

type: list of string


NixOS Options
────────────────────
# services.openssh.settings.DenyUsers
If specified, login is denied for all listed users. Takes
precedence over [](#opt-services.openssh.settings.AllowUsers).
See {manpage}`sshd_config(5)` for details.

type: null or (list of string)


NixOS Options
────────────────────
# services.openssh.startWhenNeeded
If set, {command}`sshd` is socket-activated; that
is, instead of having it permanently running as a daemon,
systemd will start an instance for each incoming connection.

type: boolean


NixOS Options
────────────────────
# services.openssh.settings.PermitRootLogin
Whether the root user can login using ssh.

type: one of "yes", "without-password", "prohibit-password", "forced-commands-only", "no"


NixOS Options
────────────────────
# services.openssh.settings.AllowUsers
If specified, login is allowed only for the listed users.
See {manpage}`sshd_config(5)` for details.

type: null or (list of string)


NixOS Options
────────────────────
# services.openssh.knownHosts.<name>.certAuthority
This public key is an SSH certificate authority, rather than an
individual host's key.

type: boolean


NixOS Options
────────────────────
# services.openssh.moduliFile
Path to `moduli` file to install in
`/etc/ssh/moduli`. If this option is unset, then
the `moduli` file shipped with OpenSSH will be used.

type: path


NixOS Options
────────────────────
# services.openssh.settings.KexAlgorithms
Allowed key exchange algorithms

Uses the lower bound recommended in both
<https://stribika.github.io/2015/01/04/secure-secure-shell.html>
and
<https://infosec.mozilla.org/guidelines/openssh#modern-openssh-67>

type: list of string


NixDarwin Options
────────────────────
# services.openssh.authorizedKeysFiles
Specify the rules for which files to read on the host.

This is an advanced option. If you're looking to configure user
keys, you can generally use [](#opt-users.users._name_.openssh.authorizedKeys.keys)
or [](#opt-users.users._name_.openssh.authorizedKeys.keyFiles).

These are paths relative to the host root file system or home
directories and they are subject to certain token expansion rules.
See AuthorizedKeysFile in man sshd_config for details.

type: list of string


