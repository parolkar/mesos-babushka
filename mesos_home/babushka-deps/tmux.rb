dep 'tmuxinator configured' do
  requires 'tmuxinator.gem'
  requires 'tmux.managed' 
end


dep 'tmuxinator.gem' do
  provides %w[tmuxinator]
end

dep 'tmux.managed' do
  provides %w[tmux]
end
