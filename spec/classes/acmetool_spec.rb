require 'spec_helper'

describe 'acmetool' do
	let (:title) { 'foo' }
	let (:facts) { { :osfamily => 'Debian', :lsbdistid => 'Debian' } }

	context 'default-params' do
		it { is_expected.to compile.with_all_deps }
	end
end

