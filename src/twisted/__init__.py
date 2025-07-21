# -*- test-case-name: twisted -*-

# Copyright (c) Twisted Matrix Laboratories.
# See LICENSE for details.

"""
Twisted: The Framework Of Your Internet.

Twisted is an event-driven networking engine written in Python and licensed
under the open source MIT license. It supports many common network protocols,
including SMTP, POP3, IMAP, SSHv2, and SOCKSv4, and provides tools for
creating new protocols.

Key Features:
- Asynchronous programming model using Deferreds
- Cross-platform networking support
- Comprehensive protocol implementations
- Plugin system for extensibility
- Testing framework (Trial)
"""

from twisted._version import __version__ as version

__version__ = version.short()
