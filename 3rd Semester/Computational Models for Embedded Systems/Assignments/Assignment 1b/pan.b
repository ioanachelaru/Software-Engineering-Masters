	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* PROC SMC */

	case 3: /* STATE 1 */
		;
		XX = 1;
		unrecv(now.signal, XX-1, 0, 3, 1);
		;
		;
		goto R999;
;
		;
		
	case 5: /* STATE 3 */
		;
		_m = unsend(now.signal);
		;
		goto R999;

	case 6: /* STATE 4 */
		;
		_m = unsend(now.signal);
		;
		goto R999;

	case 7: /* STATE 8 */
		;
		controller_running = trpt->bup.oval;
		;
		goto R999;

	case 8: /* STATE 10 */
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC MP */

	case 9: /* STATE 1 */
		;
		XX = 1;
		unrecv(now.signal, XX-1, 0, 1, 1);
		;
		;
		goto R999;
;
		
	case 10: /* STATE 2 */
		goto R999;

	case 11: /* STATE 6 */
		;
		user_notified = trpt->bup.oval;
		;
		goto R999;

	case 12: /* STATE 8 */
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC SC */

	case 13: /* STATE 1 */
		;
		XX = 1;
		unrecv(now.signal, XX-1, 0, 2, 1);
		;
		;
		goto R999;
;
		
	case 14: /* STATE 2 */
		goto R999;

	case 15: /* STATE 6 */
		;
		camera_records = trpt->bup.oval;
		;
		goto R999;

	case 16: /* STATE 8 */
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC MS */
;
		;
		
	case 18: /* STATE 3 */
		;
		now.secondsCount = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 20: /* STATE 7 */
		;
		_m = unsend(now.signal);
		;
		goto R999;

	case 21: /* STATE 8 */
		;
		now.secondsCount = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 23: /* STATE 12 */
		;
		now.secondsCount = trpt->bup.oval;
		;
		goto R999;

	case 24: /* STATE 18 */
		;
		movement_detected = trpt->bup.oval;
		;
		goto R999;

	case 25: /* STATE 20 */
		;
		p_restor(II);
		;
		;
		goto R999;
	}

