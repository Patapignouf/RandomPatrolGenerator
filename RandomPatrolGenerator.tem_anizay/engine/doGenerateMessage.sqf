_thisMessage     = _this select 0;
_thisSide       = _this select 1;

if (!isDedicated) then 
{
	if (side player == _thisSide) then
	{
		hint  _thisMessage;
	};
};

