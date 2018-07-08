# Extend Makefile

You can extend the existing Makefile commands, or/and add own commands for your local use with additional Makefiles.

* [Local Config files](#local-config-files)
* [Prepend code to existing make commands](#prepend-code-to-existing-make-commands)
* [Append code to existing make commands](#append-code-to-existing-make-commands)
* [Add own make commands](#add-own-make-commands)

## Local Config files

The default overriding files for prepending and appending code to an existing Makefile command are:

_./local/Makefile.override.prepend_

_./local/Makefile.override.append_

If you want to use another path you can configure this path in your .env file:

```
MAKEFILE_OVERRIDE_PREPEND=./local/Makefile.override.prepend
MAKEFILE_OVERRIDE_APPEND=./local/Makefile.override.append
```

E.g. for usage with an global makefile to add commands to all your projects with this setup.

**Note:** Use the **_command::_** Syntax. Don't use **_command:_**

## Prepend code to existing make commands

Original command within _Makefile_:

```makefile
help::
	@echo ""
	@echo "Command           | Shorthand | Description"
	@echo ""
```

Extensing with a prepending echo command in your _./local/Makefile.override.prepend_ file:

```makefile
help::
	@echo "This is a prepending echo :)"
```

Result:

```bash
$ make help

This is a prepending echo :)

Command           | Shorthand | Description

```

## Append code to existing make commands

Original command within _Makefile_:

```makefile
help::
	@echo ""
	@echo "Command           | Shorthand | Description"
	@echo ""
```

Extensing with a appending echo command in your _./local/Makefile.override.append_ file:

```makefile
help::
	@echo "This is a appending echo :)"
```

Result:

```bash
$ make help

Command           | Shorthand | Description

This is a appending echo :)
``` 

## Add own make commands

To add own commands, you can just create a new command in one of both files.

```makefile
mycommand::
	@echo "This is my additional command."
```