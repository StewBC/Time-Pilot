#pragma once

#define set(verStr) namespace time_pilotVersion { extern int Major, Minor, Revision; struct Parser { Parser(const char*);  }; static Parser parser(#verStr); }

set("TIME_PILOT_VERSION" "1.0.0")

#undef set

#endif
