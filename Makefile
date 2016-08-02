
HUGO ?= hugo
RSYNC_FLAGS = -rvzPp --chmod=Dg+s,ug+rwX,o=rX --delete

all: public/index.html

public/index.html:
	$(HUGO)

clean:
	rm -rf public

upload: all
	# Prevent catastrophy by making sure we are not going to rsync --delete
	# directory names that are known to have content on the server
	[ ! -d public/releases ] || exit 1
	[ ! -d public/doc ] || exit 1
	[ ! -d public/spec ] || exit 1
	[ ! -d public/spec-snapshot ] || exit 1
	[ ! -d public/xmpp ] || exit 1
	# WARNING - The wildcard in public/* is really important.
	# Removing it can end up deleting all the above directories on the server anyway
	rsync $(RSYNC_FLAGS) public/* telepathy.freedesktop.org:/srv/telepathy.freedesktop.org/www/
