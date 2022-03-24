#define rand	pan_rand
#if defined(HAS_CODE) && defined(VERBOSE)
	cpu_printf("Pr: %d Tr: %d\n", II, t->forw);
#endif
	switch (t->forw) {
	default: Uerror("bad forward move");
	case 0:	/* if without executable clauses */
		continue;
	case 1: /* generic 'goto' or 'skip' */
		IfNotBlocked
		_m = 3; goto P999;
	case 2: /* generic 'else' */
		IfNotBlocked
		if (trpt->o_pm&1) continue;
		_m = 3; goto P999;

		 /* PROC SMC */
	case 3: /* STATE 1 - assignment1b:81 - [signal?registerMovement] (0:0:0 - 1) */
		reached[3][1] = 1;
		if (boq != now.signal) continue;
		if (q_len(now.signal) == 0) continue;

		XX=1;
		if (3 != qrecv(now.signal, 0, 0, 0)) continue;
		if (q_flds[((Q0 *)qptr(now.signal-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
		;
		qrecv(now.signal, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", now.signal);
		sprintf(simtmp, "%d", 3); strcat(simvals, simtmp);		}
#endif
		if (q_zero(now.signal))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3d: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 4: /* STATE 2 - assignment1b:82 - [printf('New activity registered \\n')] (0:0:0 - 1) */
		IfNotBlocked
		reached[3][2] = 1;
		Printf("New activity registered \n");
		_m = 3; goto P999; /* 0 */
	case 5: /* STATE 3 - assignment1b:83 - [signal!notifyCamera] (0:0:0 - 1) */
		IfNotBlocked
		reached[3][3] = 1;
		if (q_len(now.signal))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d!", now.signal);
		sprintf(simtmp, "%d", 2); strcat(simvals, simtmp);		}
#endif
		
		qsend(now.signal, 0, 2, 1);
		{ boq = now.signal; };
		_m = 2; goto P999; /* 0 */
	case 6: /* STATE 4 - assignment1b:84 - [signal!notifyUser] (0:0:0 - 1) */
		IfNotBlocked
		reached[3][4] = 1;
		if (q_len(now.signal))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d!", now.signal);
		sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);		}
#endif
		
		qsend(now.signal, 0, 1, 1);
		{ boq = now.signal; };
		_m = 2; goto P999; /* 0 */
	case 7: /* STATE 8 - assignment1b:91 - [controller_running = 1] (0:0:1 - 1) */
		IfNotBlocked
		reached[3][8] = 1;
		(trpt+1)->bup.oval = ((int)controller_running);
		controller_running = 1;
#ifdef VAR_RANGES
		logval("controller_running", ((int)controller_running));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 8: /* STATE 10 - assignment1b:93 - [-end-] (0:0:0 - 1) */
		IfNotBlocked
		reached[3][10] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC MP */
	case 9: /* STATE 1 - assignment1b:66 - [signal?notifyUser] (0:0:0 - 1) */
		reached[2][1] = 1;
		if (boq != now.signal) continue;
		if (q_len(now.signal) == 0) continue;

		XX=1;
		if (1 != qrecv(now.signal, 0, 0, 0)) continue;
		if (q_flds[((Q0 *)qptr(now.signal-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
		;
		qrecv(now.signal, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", now.signal);
		sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);		}
#endif
		if (q_zero(now.signal))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3d: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 10: /* STATE 2 - assignment1b:67 - [printf('User has been notified \\n')] (0:7:0 - 1) */
		IfNotBlocked
		reached[2][2] = 1;
		Printf("User has been notified \n");
		/* merge: goto finished(7, 3, 7) */
		reached[2][3] = 1;
		;
		_m = 3; goto P999; /* 1 */
	case 11: /* STATE 6 - assignment1b:74 - [user_notified = 1] (0:0:1 - 1) */
		IfNotBlocked
		reached[2][6] = 1;
		(trpt+1)->bup.oval = ((int)user_notified);
		user_notified = 1;
#ifdef VAR_RANGES
		logval("user_notified", ((int)user_notified));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 12: /* STATE 8 - assignment1b:76 - [-end-] (0:0:0 - 1) */
		IfNotBlocked
		reached[2][8] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC SC */
	case 13: /* STATE 1 - assignment1b:51 - [signal?notifyCamera] (0:0:0 - 1) */
		reached[1][1] = 1;
		if (boq != now.signal) continue;
		if (q_len(now.signal) == 0) continue;

		XX=1;
		if (2 != qrecv(now.signal, 0, 0, 0)) continue;
		if (q_flds[((Q0 *)qptr(now.signal-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
		;
		qrecv(now.signal, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", now.signal);
		sprintf(simtmp, "%d", 2); strcat(simvals, simtmp);		}
#endif
		if (q_zero(now.signal))
		{	boq = -1;
#ifndef NOFAIR
			if (fairness
			&& !(trpt->o_pm&32)
			&& (now._a_t&2)
			&&  now._cnt[now._a_t&1] == II+2)
			{	now._cnt[now._a_t&1] -= 1;
#ifdef VERI
				if (II == 1)
					now._cnt[now._a_t&1] = 1;
#endif
#ifdef DEBUG
			printf("%3d: proc %d fairness ", depth, II);
			printf("Rule 2: --cnt to %d (%d)\n",
				now._cnt[now._a_t&1], now._a_t);
#endif
				trpt->o_pm |= (32|64);
			}
#endif

		};
		_m = 4; goto P999; /* 0 */
	case 14: /* STATE 2 - assignment1b:52 - [printf('Camera started recording \\n')] (0:7:0 - 1) */
		IfNotBlocked
		reached[1][2] = 1;
		Printf("Camera started recording \n");
		/* merge: goto finished(7, 3, 7) */
		reached[1][3] = 1;
		;
		_m = 3; goto P999; /* 1 */
	case 15: /* STATE 6 - assignment1b:59 - [camera_records = 1] (0:0:1 - 1) */
		IfNotBlocked
		reached[1][6] = 1;
		(trpt+1)->bup.oval = ((int)camera_records);
		camera_records = 1;
#ifdef VAR_RANGES
		logval("camera_records", ((int)camera_records));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 16: /* STATE 8 - assignment1b:61 - [-end-] (0:0:0 - 1) */
		IfNotBlocked
		reached[1][8] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC MS */
	case 17: /* STATE 1 - assignment1b:25 - [((secondsCount<3))] (0:0:0 - 1) */
		IfNotBlocked
		reached[0][1] = 1;
		if (!((((int)now.secondsCount)<3)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 18: /* STATE 2 - assignment1b:26 - [printf('MS is on the hunt, waiting for movement \\n')] (0:17:1 - 1) */
		IfNotBlocked
		reached[0][2] = 1;
		Printf("MS is on the hunt, waiting for movement \n");
		/* merge: secondsCount = (secondsCount+1)(17, 3, 17) */
		reached[0][3] = 1;
		(trpt+1)->bup.oval = ((int)now.secondsCount);
		now.secondsCount = (((int)now.secondsCount)+1);
#ifdef VAR_RANGES
		logval("secondsCount", ((int)now.secondsCount));
#endif
		;
		/* merge: goto hunting(17, 4, 17) */
		reached[0][4] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 19: /* STATE 6 - assignment1b:31 - [((secondsCount==3))] (0:0:0 - 1) */
		IfNotBlocked
		reached[0][6] = 1;
		if (!((((int)now.secondsCount)==3)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 20: /* STATE 7 - assignment1b:32 - [signal!registerMovement] (0:0:0 - 1) */
		IfNotBlocked
		reached[0][7] = 1;
		if (q_len(now.signal))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d!", now.signal);
		sprintf(simtmp, "%d", 3); strcat(simvals, simtmp);		}
#endif
		
		qsend(now.signal, 0, 3, 1);
		{ boq = now.signal; };
		_m = 2; goto P999; /* 0 */
	case 21: /* STATE 8 - assignment1b:33 - [secondsCount = 0] (0:17:1 - 1) */
		IfNotBlocked
		reached[0][8] = 1;
		(trpt+1)->bup.oval = ((int)now.secondsCount);
		now.secondsCount = 0;
#ifdef VAR_RANGES
		logval("secondsCount", ((int)now.secondsCount));
#endif
		;
		/* merge: goto hunting(17, 9, 17) */
		reached[0][9] = 1;
		;
		_m = 3; goto P999; /* 1 */
	case 22: /* STATE 11 - assignment1b:36 - [((secondsCount==3))] (0:0:0 - 1) */
		IfNotBlocked
		reached[0][11] = 1;
		if (!((((int)now.secondsCount)==3)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 23: /* STATE 12 - assignment1b:37 - [secondsCount = 0] (0:19:1 - 1) */
		IfNotBlocked
		reached[0][12] = 1;
		(trpt+1)->bup.oval = ((int)now.secondsCount);
		now.secondsCount = 0;
#ifdef VAR_RANGES
		logval("secondsCount", ((int)now.secondsCount));
#endif
		;
		/* merge: goto finished(19, 13, 19) */
		reached[0][13] = 1;
		;
		_m = 3; goto P999; /* 1 */
	case 24: /* STATE 18 - assignment1b:44 - [movement_detected = 1] (0:0:1 - 1) */
		IfNotBlocked
		reached[0][18] = 1;
		(trpt+1)->bup.oval = ((int)movement_detected);
		movement_detected = 1;
#ifdef VAR_RANGES
		logval("movement_detected", ((int)movement_detected));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 25: /* STATE 20 - assignment1b:46 - [-end-] (0:0:0 - 1) */
		IfNotBlocked
		reached[0][20] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */
	case  _T5:	/* np_ */
		if (!((!(trpt->o_pm&4) && !(trpt->tau&128))))
			continue;
		/* else fall through */
	case  _T2:	/* true */
		_m = 3; goto P999;
#undef rand
	}

