function ft_realtime_ctfproxy(cfg)

% FT_REALTIME_CTFPROXY reads continuous data from shared memory on a CTF acquisition
% system and writes it to a FieldTrip buffer.
%
% The FieldTrip buffer is a network transparent server that allows the acquisition
% client to stream data to it. An analysis client can connect to read the data upon
% request. Multiple clients can connect simultaneously, each analyzing a specific
% aspect of the data concurrently.
%
% Since the CTF shared memory interface is only available on the acquisition machine
% itself, this function must run on the acquisition machine. The buffer to which the
% data is streamed is available through the network, so the actual analysis can be
% done elsewhere.
%
% Use as
%   ft_realtime_ctfproxy(cfg)
%
% The target to write the data to is configured as
%   cfg.target.datafile      = string, target destination for the data (default = 'buffer://localhost:1972')
%   cfg.target.dataformat    = string, default is determined automatic
%
% To stop this realtime function, you have to press Ctrl-C
%
% See also FT_REALTIME_SIGNALPROXY, FT_REALTIME_SIGNALVIEWER

% Copyright (C) 2008, Robert Oostenveld
%
% This file is part of FieldTrip, see http://www.ru.nl/neuroimaging/fieldtrip
% for the documentation and details.
%
%    FieldTrip is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    FieldTrip is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with FieldTrip. If not, see <http://www.gnu.org/licenses/>.
%
% $Id: ft_realtime_ctfproxy.m 10300 2015-03-29 17:34:39Z roboos $

% set the defaults
if ~isfield(cfg, 'target'),             cfg.target = [];                                  end
if ~isfield(cfg.target, 'datafile'),    cfg.target.datafile = 'buffer://localhost:1972';  end
if ~isfield(cfg.target, 'dataformat'),  cfg.target.dataformat = [];                       end % default is to use autodetection of the output format

% use another function to do the actual work
cfg.jumptoeof = 'yes';
cfg.readevent = 'yes';
cfg.source.datafile   = 'shm://';
cfg.source.dataformat = 'ctf_shm';
ft_realtime_fileproxy(cfg);

